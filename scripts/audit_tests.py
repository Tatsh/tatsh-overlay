#!/usr/bin/env python
"""Audit overlay ebuilds for upstream test presence.

For each ebuild this script:

1. Detects the primary build system from inherited eclasses.
2. Decides whether tests are applicable at all (some categories — libretro
   cores, mpv plugins, font and account packages — do not have upstream
   tests by their nature).
3. Resolves the upstream GitHub repository from ``SRC_URI``, ``HOMEPAGE``
   or ``metadata.xml`` and lists its files via the GitHub trees API.
4. Classifies whether the upstream has tests and under which framework.
5. Emits a CSV row per ebuild.

The CSV is the input checklist for subsequent ``src_test`` enabling
phases — it is not authoritative; every flagged ebuild still needs human
review before edits.
"""
from __future__ import annotations

from collections.abc import Iterable, Sequence
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import urlparse
import argparse
import csv
import json
import logging
import os
import re
import sys
import time

import requests

logger = logging.getLogger('audit_tests')

sys.path.insert(0, str(Path(__file__).resolve().parent))
from ebuild_parser import EbuildParser  # noqa: E402

CACHE_DIR = Path(os.environ.get('XDG_CACHE_HOME', str(
    Path.home() / '.cache'))) / 'tatsh-overlay-audit'
GITHUB_API = 'https://api.github.com'
PYPI_API = 'https://pypi.org/pypi'
USER_AGENT = 'tatsh-overlay-audit/1.0 (+https://github.com/Tatsh/tatsh-overlay)'

# Inherited eclasses that imply tests are not applicable.
NA_INHERIT = frozenset({
    'libretro-core',
    'libretro',
    'mpv-plugin',
    'mpv-shader',
    'font',
    'vim-plugin',
    'webapp',
})
# Categories where tests are not applicable.
NA_CATEGORIES = frozenset({
    'acct-user',
    'acct-group',
    'app-vim',
    'media-fonts',
    'mpv-plugin',
    'mpv-shader',
})

# Eclass → build system.
BUILD_SYSTEMS = {
    'distutils-r1': 'python',
    'python-r1': 'python-multi',
    'python-single-r1': 'python-single',
    'cargo': 'cargo',
    'go-module': 'go',
    'cmake': 'cmake',
    'meson': 'meson',
    'autotools': 'autotools',
    'yarn': 'yarn',
    'ruby-fakegem': 'ruby',
    'linux-mod-r1': 'kmod',
}


@dataclass
class AuditResult:
    """A single audit row."""
    ebuild: str
    category: str
    package: str
    build_system: str
    upstream_kind: str
    upstream_ref: str
    has_tests: bool
    test_framework: str
    already_enabled: bool
    notes: str


def github_owner_repo(url: str) -> tuple[str, str] | None:
    """Return (owner, repo) for a GitHub URL, else None."""
    if 'github.com' not in url:
        return None
    parsed = urlparse(url if '://' in url else f'https://{url}')
    if parsed.hostname not in {'github.com', 'www.github.com', 'codeload.github.com'}:
        return None
    parts = [p for p in parsed.path.split('/') if p]
    if len(parts) < 2:
        return None
    owner = parts[0]
    repo = parts[1].removesuffix('.git')
    if owner in {'orgs', 'sponsors', 'apps'}:
        return None
    return owner, repo


def cache_path_for(name: str) -> Path:
    safe = re.sub(r'[^A-Za-z0-9._-]+', '_', name)
    return CACHE_DIR / safe


def fetch_github_tree(owner: str, repo: str, ref: str,
                      token: str | None) -> tuple[list[str], bool] | None:
    """Fetch the recursive file list for a GitHub repo at ref.

    Returns ``(paths, truncated)`` or ``None`` on hard failure (404,
    network error, etc.).
    """
    cache = cache_path_for(f'gh_{owner}_{repo}_{ref}.json')
    if cache.exists():
        data = json.loads(cache.read_text())
        logger.debug('cache hit %s/%s@%s (%d paths)', owner, repo, ref, len(data['paths']))
        return data['paths'], data['truncated']
    headers = {
        'User-Agent': USER_AGENT,
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
    }
    if token:
        headers['Authorization'] = f'Bearer {token}'
    url = f'{GITHUB_API}/repos/{owner}/{repo}/git/trees/{ref}?recursive=1'
    logger.debug('GET %s', url)
    t0 = time.monotonic()
    try:
        resp = requests.get(url, headers=headers, timeout=15)
    except requests.RequestException as exc:
        logger.warning('request failed for %s/%s@%s: %s', owner, repo, ref, exc)
        return None
    elapsed = time.monotonic() - t0
    logger.debug('response %d in %.2fs for %s/%s@%s', resp.status_code, elapsed, owner, repo, ref)
    if resp.status_code == 403 and 'rate limit' in resp.text.lower():
        reset = int(resp.headers.get('X-RateLimit-Reset', '0'))
        wait = max(0, reset - int(time.time())) + 5
        logger.warning('rate-limited; sleeping %ds', wait)
        time.sleep(wait)
        try:
            resp = requests.get(url, headers=headers, timeout=15)
        except requests.RequestException as exc:
            logger.warning('retry failed for %s/%s@%s: %s', owner, repo, ref, exc)
            return None
    if resp.status_code == 404:
        return None
    if not resp.ok:
        logger.warning('non-OK %d for %s/%s@%s', resp.status_code, owner, repo, ref)
        return None
    data = resp.json()
    paths = [item['path'] for item in data.get('tree', [])]
    truncated = bool(data.get('truncated'))
    cache.parent.mkdir(parents=True, exist_ok=True)
    cache.write_text(json.dumps({'paths': paths, 'truncated': truncated}))
    return paths, truncated


def candidate_refs(pv: str) -> list[str]:
    """Plausible git tags for an ebuild PV."""
    refs = [f'v{pv}', pv, f'release-v{pv}', f'release-{pv}']
    if '_p' in pv:
        base = pv.split('_p', 1)[0]
        refs.extend([f'v{base}', base])
    if '_pre' in pv:
        base = pv.split('_pre', 1)[0]
        refs.extend([f'v{base}', base])
    refs.extend(['main', 'master'])
    seen: set[str] = set()
    out = []
    for r in refs:
        if r and r not in seen:
            seen.add(r)
            out.append(r)
    return out


def parse_ebuild_filename(path: Path) -> dict[str, str]:
    """Reconstruct Portage's implicit ``PN``/``PV``/``P``/``PR``/``PVR`` from the file path.

    Portage derives these from the filename + parent directory; ebuilds rarely
    set them explicitly. Any standalone parser must do the same.
    """
    pn = path.parent.name
    stem = path.stem
    if not stem.startswith(pn + '-'):
        return {'PN': pn}
    rest = stem[len(pn) + 1:]
    if m := re.search(r'-r(\d+)$', rest):
        pr_num = m.group(1)
        pv = rest[:m.start()]
    else:
        pr_num = ''
        pv = rest
    return {
        'PN': pn,
        'PV': pv,
        'P': f'{pn}-{pv}',
        'PR': f'r{pr_num}' if pr_num else 'r0',
        'PVR': f'{pv}-r{pr_num}' if pr_num else pv,
    }


def find_github_for_ebuild(parser: EbuildParser, ebuild_path: Path) -> tuple[str, str] | None:
    """Resolve a (owner, repo) tuple for the upstream of this ebuild."""
    for k, v in parse_ebuild_filename(ebuild_path).items():
        parser.variables.setdefault(k, v)
    src_uri = parser.get_variable('SRC_URI', expand=True, convert=True)
    if isinstance(src_uri, dict):
        for uri in src_uri:
            gh = github_owner_repo(uri)
            if gh:
                return gh
    homepage = parser.get_variable('HOMEPAGE', expand=True)
    if isinstance(homepage, str):
        for token in re.split(r'\s+', homepage):
            gh = github_owner_repo(token)
            if gh:
                return gh
    meta_path = ebuild_path.parent / 'metadata.xml'
    if meta_path.exists():
        text = meta_path.read_text()
        if m := re.search(r'<remote-id type="github">\s*([^<\s]+)\s*</remote-id>', text):
            value = m.group(1).strip()
            if '/' in value:
                owner, repo = value.split('/', 1)
                return owner, repo.removesuffix('.git')
    return None


def detect_build_system(eclasses: Sequence[str]) -> str:
    """Return the build system name based on inherited eclasses."""
    if not eclasses:
        return 'none'
    for e in eclasses:
        if e in BUILD_SYSTEMS:
            return BUILD_SYSTEMS[e]
    return 'other'


def is_na(category: str, eclasses: Sequence[str], build_system: str) -> tuple[bool, str]:
    """Return (is_not_applicable, reason)."""
    if category in NA_CATEGORIES:
        return True, f'category={category}'
    eclass_set = set(eclasses)
    overlap = eclass_set & NA_INHERIT
    if overlap:
        return True, f'eclass={sorted(overlap)[0]}'
    if build_system == 'none':
        return True, 'no build system'
    if build_system == 'kmod':
        return True, 'kernel module'
    return False, ''


def already_handles_tests(parser: EbuildParser) -> bool:
    """Whether the ebuild already wires tests in some form.

    Includes the case where the maintainer has deliberately set
    ``RESTRICT="test"`` — that is a conscious decision (tests need
    network, GPUs, models, etc.) and Phase 1 should leave those alone.
    """
    text = parser.content
    if 'distutils_enable_tests' in text:
        return True
    if 'src_test' in parser.phases:
        return True
    restrict = parser.get_variable('RESTRICT')
    if isinstance(restrict, str) and re.search(r'\btest\b', restrict):
        return True
    iuse = parser.get_variable('IUSE')
    if isinstance(iuse, str) and re.search(r'\btest\b', iuse):
        return True
    return False


def detect_upstream_tests(build_system: str, paths: Iterable[str]) -> tuple[bool, str, str]:
    """Inspect upstream paths and decide whether tests exist.

    Returns ``(has_tests, framework, notes)``.
    """
    paths_list = list(paths)
    has_tests_dir = any(
        p == 'tests' or p == 'test' or p.startswith('tests/') or p.startswith('test/')
        for p in paths_list)
    has_pyproject = 'pyproject.toml' in paths_list
    has_setup_py = 'setup.py' in paths_list
    has_tox = 'tox.ini' in paths_list
    has_pytest_ini = 'pytest.ini' in paths_list
    has_conftest = any(p.endswith('conftest.py') for p in paths_list)

    if build_system in {'python', 'python-multi', 'python-single'}:
        if (has_tests_dir or has_conftest or has_pytest_ini or has_tox
                or any(p.endswith('_test.py') for p in paths_list)
                or any(re.match(r'(^|/)test_[^/]+\.py$', p) for p in paths_list)):
            framework = 'pytest'
            note = ''
            if not (has_pyproject or has_setup_py):
                note = 'no pyproject/setup.py — verify framework manually'
            return True, framework, note
        return False, '', ''
    if build_system == 'go':
        if any(p.endswith('_test.go') for p in paths_list):
            return True, 'go', ''
        return False, '', ''
    if build_system == 'cargo':
        if has_tests_dir:
            return True, 'cargo', 'integration tests directory'
        # Inline #[test] blocks cannot be detected from filenames; flag uncertain.
        return False, '', 'uncertain — Cargo inline tests not detectable'
    if build_system == 'cmake':
        # CMake projects with a test directory or CTestConfig usually wire tests.
        if has_tests_dir or 'CTestConfig.cmake' in paths_list:
            return True, 'cmake', 'verify BUILD_TESTING toggle in CMakeLists.txt'
        return False, '', ''
    if build_system == 'meson':
        if has_tests_dir:
            return True, 'meson', ''
        return False, '', ''
    if build_system == 'autotools':
        if (has_tests_dir or any(p.endswith('Makefile.am') for p in paths_list)
                or 'configure.ac' in paths_list):
            # presence of automake doesn't guarantee `make check`; flag for review
            return has_tests_dir, 'autotools', 'check Makefile.am for check_PROGRAMS'
        return False, '', ''
    if build_system == 'yarn':
        return 'package.json' in paths_list, 'yarn', 'inspect package.json scripts.test'
    if build_system == 'ruby':
        if has_tests_dir or any(p.startswith('spec/') for p in paths_list):
            return True, 'ruby', ''
        return False, '', ''
    return False, '', ''


def audit_ebuild(path: Path, repo_root: Path, token: str | None) -> AuditResult:
    """Produce one AuditResult for the given ebuild path."""
    parser = EbuildParser(str(path))
    category = path.parent.parent.name
    package = path.parent.name
    build_system = detect_build_system(parser.eclasses)
    rel = str(path.relative_to(repo_root))
    already = already_handles_tests(parser)
    na, na_reason = is_na(category, parser.eclasses, build_system)
    if na:
        return AuditResult(ebuild=rel,
                           category=category,
                           package=package,
                           build_system=build_system,
                           upstream_kind='n/a',
                           upstream_ref='',
                           has_tests=False,
                           test_framework='',
                           already_enabled=already,
                           notes=f'N/A ({na_reason})')
    gh = find_github_for_ebuild(parser, path)
    if not gh:
        return AuditResult(ebuild=rel,
                           category=category,
                           package=package,
                           build_system=build_system,
                           upstream_kind='unknown',
                           upstream_ref='',
                           has_tests=False,
                           test_framework='',
                           already_enabled=already,
                           notes='no GitHub upstream — manual review needed')
    owner, repo = gh
    pv = parse_ebuild_filename(path).get('PV', '')
    paths_list: list[str] | None = None
    used_ref = ''
    truncated = False
    for ref in candidate_refs(pv):
        result = fetch_github_tree(owner, repo, ref, token)
        if result is not None:
            paths_list, truncated = result
            used_ref = ref
            break
    if paths_list is None:
        return AuditResult(ebuild=rel,
                           category=category,
                           package=package,
                           build_system=build_system,
                           upstream_kind='github',
                           upstream_ref=f'{owner}/{repo}',
                           has_tests=False,
                           test_framework='',
                           already_enabled=already,
                           notes='no resolvable git ref')
    has_tests, framework, note = detect_upstream_tests(build_system, paths_list)
    if truncated and not note:
        note = 'tree truncated by GitHub — partial listing'
    elif truncated and note:
        note = f'{note}; tree truncated'
    return AuditResult(ebuild=rel,
                       category=category,
                       package=package,
                       build_system=build_system,
                       upstream_kind='github',
                       upstream_ref=f'{owner}/{repo}@{used_ref}',
                       has_tests=has_tests,
                       test_framework=framework,
                       already_enabled=already,
                       notes=note)


def find_overlay_root(start: Path) -> Path:
    """Walk upward from ``start`` until ``profiles/repo_name`` is found."""
    cur = start.resolve()
    while cur != cur.parent:
        if (cur / 'profiles' / 'repo_name').exists():
            return cur
        cur = cur.parent
    return start


CSV_HEADER = (
    'ebuild',
    'category',
    'package',
    'build_system',
    'upstream_kind',
    'upstream_ref',
    'has_tests',
    'test_framework',
    'already_enabled',
    'notes',
)


def _row_for(r: AuditResult) -> tuple[str, ...]:
    return (
        r.ebuild,
        r.category,
        r.package,
        r.build_system,
        r.upstream_kind,
        r.upstream_ref,
        str(r.has_tests).lower(),
        r.test_framework,
        str(r.already_enabled).lower(),
        r.notes,
    )


def main() -> int:
    """Walk the overlay and emit the audit CSV."""
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', default='tests-audit.csv', help='CSV output path')
    ap.add_argument('--token',
                    default=os.environ.get('GITHUB_TOKEN'),
                    help='GitHub API token (or set GITHUB_TOKEN)')
    ap.add_argument('--limit', type=int, default=0, help='Stop after N ebuilds (0 = all)')
    ap.add_argument('--filter', default='', help='Substring filter on relative ebuild path')
    ap.add_argument('-v', '--verbose', action='count', default=0, help='-v info, -vv debug')
    args = ap.parse_args()

    log_level = logging.WARNING
    if args.verbose >= 2:
        log_level = logging.DEBUG
    elif args.verbose == 1:
        log_level = logging.INFO
    logging.basicConfig(level=log_level,
                        format='%(asctime)s %(levelname)s %(name)s %(message)s',
                        stream=sys.stderr)

    overlay_root = find_overlay_root(Path(__file__).resolve().parent)
    ebuilds = sorted(p for p in overlay_root.rglob('*.ebuild') if 'node_modules' not in p.parts)
    if args.filter:
        ebuilds = [p for p in ebuilds if args.filter in str(p)]
    if args.limit:
        ebuilds = ebuilds[:args.limit]

    if not args.token:
        logger.warning('no GitHub token; rate-limited to 60 requests/hour')
    logger.info('auditing %d ebuilds; output -> %s', len(ebuilds), args.output)

    out_path = (overlay_root / args.output).resolve()
    with out_path.open('w', newline='') as f:
        w = csv.writer(f)
        w.writerow(CSV_HEADER)
        f.flush()
        for i, ebuild in enumerate(ebuilds, start=1):
            t0 = time.monotonic()
            try:
                result = audit_ebuild(ebuild, overlay_root, args.token)
            except Exception as exc:  # noqa: BLE001
                rel = str(ebuild.relative_to(overlay_root))
                logger.exception('error processing %s', rel)
                result = AuditResult(ebuild=rel,
                                     category=ebuild.parent.parent.name,
                                     package=ebuild.parent.name,
                                     build_system='error',
                                     upstream_kind='',
                                     upstream_ref='',
                                     has_tests=False,
                                     test_framework='',
                                     already_enabled=False,
                                     notes=f'ERROR: {exc}')
            elapsed = time.monotonic() - t0
            w.writerow(_row_for(result))
            f.flush()
            print(
                f'[{i}/{len(ebuilds)}] ({elapsed:.1f}s) {result.ebuild} '
                f'| bs={result.build_system} | up={result.upstream_kind} '
                f'| tests={result.has_tests} | fw={result.test_framework} '
                f'| already={result.already_enabled} | {result.notes}',
                file=sys.stderr,
                flush=True)
    logger.info('done — wrote %d rows to %s', len(ebuilds), out_path)
    return 0


if __name__ == '__main__':
    sys.exit(main())
