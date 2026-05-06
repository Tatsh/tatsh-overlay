#!/usr/bin/env python
"""For each already-enabled Python ebuild, compare upstream test deps with BDEPEND.

Reports gaps where a known pytest plugin appears in the upstream test/dev
dependency group but is not referenced under ``BDEPEND="test? ( ... )"`` in
the ebuild. The output is advisory — every gap should still be checked
manually before any edit.
"""
from __future__ import annotations

from pathlib import Path
import argparse
import csv
import logging
import os
import re
import sys
import tomllib

import requests

logger = logging.getLogger('check_test_deps')

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upstream_test_deps import KNOWN_PACKAGE_MAP, gentoo_has  # noqa: E402

GITHUB_RAW = 'https://raw.githubusercontent.com'
USER_AGENT = 'tatsh-overlay-audit/1.0'
CACHE_DIR = Path(os.environ.get('XDG_CACHE_HOME', str(
    Path.home() / '.cache'))) / 'tatsh-overlay-audit'


def _cache_path(name: str) -> Path:
    return CACHE_DIR / re.sub(r'[^A-Za-z0-9._-]+', '_', name)


def fetch_pyproject(owner: str, repo: str, ref: str, token: str | None) -> str | None:
    """Fetch ``pyproject.toml`` from a GitHub repo at ``ref``. Cached."""
    cache = _cache_path(f'pyproject_{owner}_{repo}_{ref}.toml')
    if cache.exists():
        return cache.read_text()
    headers = {'User-Agent': USER_AGENT}
    if token:
        headers['Authorization'] = f'Bearer {token}'
    url = f'{GITHUB_RAW}/{owner}/{repo}/{ref}/pyproject.toml'
    try:
        resp = requests.get(url, headers=headers, timeout=15)
    except requests.RequestException:
        return None
    if not resp.ok:
        return None
    cache.parent.mkdir(parents=True, exist_ok=True)
    cache.write_text(resp.text)
    return resp.text


def extract_test_deps(pyproject_text: str) -> list[str]:
    """Extract test dep names from common pyproject.toml conventions."""
    try:
        data = tomllib.loads(pyproject_text)
    except tomllib.TOMLDecodeError:
        return []
    out: list[str] = []
    poetry = data.get('tool', {}).get('poetry', {}) if isinstance(data.get('tool'), dict) else {}
    if isinstance(poetry, dict):
        groups = poetry.get('group', {})
        if isinstance(groups, dict):
            for name, val in groups.items():
                if isinstance(val, dict) and name in {'dev', 'test', 'tests', 'testing'}:
                    deps = val.get('dependencies')
                    if isinstance(deps, dict):
                        out.extend(deps.keys())
        dev_deps = poetry.get('dev-dependencies')
        if isinstance(dev_deps, dict):
            out.extend(dev_deps.keys())
    project = data.get('project', {})
    if isinstance(project, dict):
        opt = project.get('optional-dependencies', {})
        if isinstance(opt, dict):
            for name, val in opt.items():
                if name.lower() in {'test', 'tests', 'testing', 'dev'} and isinstance(val, list):
                    for spec in val:
                        if isinstance(spec, str):
                            m = re.match(r'([A-Za-z0-9_.-]+)', spec)
                            if m:
                                out.append(m.group(1))
    dep_groups = data.get('dependency-groups', {})
    if isinstance(dep_groups, dict):
        for name, val in dep_groups.items():
            if name.lower() in {'test', 'tests', 'testing', 'dev'} and isinstance(val, list):
                for spec in val:
                    if isinstance(spec, str):
                        m = re.match(r'([A-Za-z0-9_.-]+)', spec)
                        if m:
                            out.append(m.group(1))
    return [d.lower().replace('_', '-') for d in out]


# Plugins that are not required for test execution: pytest itself is added by
# distutils_enable_tests; coverage/UI plugins are cosmetic and not loaded
# unless --cov or similar is specified.
COSMETIC_PLUGINS = {
    'pytest',
    'pytest-cov',
    'pytest-instafail',
    'pytest-xdist',
    'pytest-rerunfailures',
    'pytest-timeout',
    'pytest-benchmark',
    'pytest-randomly',
    'pytest-repeat',
}


def known_plugins_in_deps(deps: list[str]) -> list[str]:
    """Return only the deps in the known-plugin map (minus cosmetic ones)."""
    return sorted(
        set(d for d in deps
            if d in KNOWN_PACKAGE_MAP and KNOWN_PACKAGE_MAP[d] and d not in COSMETIC_PLUGINS))


def ebuild_has_dep(ebuild_text: str, category_pn: str) -> bool:
    """Whether the ebuild references the given category/pn anywhere."""
    return category_pn in ebuild_text


def check_ebuild(path: Path, repo_root: Path, csv_row: dict[str, str], token: str | None) -> None:
    """Print findings for a single ebuild."""
    rel = str(path.relative_to(repo_root))
    ref_full = csv_row.get('upstream_ref') or ''
    if '@' not in ref_full:
        return
    repo, ref = ref_full.rsplit('@', 1)
    if '/' not in repo:
        return
    owner, name = repo.split('/', 1)
    py = fetch_pyproject(owner, name, ref, token)
    if not py:
        return
    deps = extract_test_deps(py)
    plugins = known_plugins_in_deps(deps)
    if not plugins:
        return
    text = path.read_text()
    missing = []
    for plugin in plugins:
        cat_pn = KNOWN_PACKAGE_MAP[plugin]
        if not gentoo_has(cat_pn):
            continue
        if not ebuild_has_dep(text, cat_pn):
            missing.append(cat_pn)
    if missing:
        print(f'{rel}: missing BDEPEND test? entries for: {missing}')


def main() -> int:
    """Walk the audit CSV and report missing test-dep BDEPEND entries."""
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--csv', default='tests-audit.csv')
    ap.add_argument('--exclude', default='', help='Path to file with ebuilds to skip')
    ap.add_argument('--token', default=os.environ.get('GITHUB_TOKEN'))
    args = ap.parse_args()

    overlay_root = Path(__file__).resolve().parent.parent
    csv_path = overlay_root / args.csv
    with csv_path.open() as f:
        rows = list(csv.DictReader(f))
    exclude: set[str] = set()
    if args.exclude:
        exclude = set(Path(args.exclude).read_text().splitlines())
    targets = [
        r for r in rows
        if r['already_enabled'] == 'true' and r['has_tests'] == 'true' and r['build_system'] in
        {'python', 'python-multi', 'python-single'} and r['ebuild'] not in exclude
    ]
    for r in targets:
        path = overlay_root / r['ebuild']
        try:
            check_ebuild(path, overlay_root, r, args.token)
        except Exception as exc:  # noqa: BLE001
            logger.warning('error processing %s: %s', r['ebuild'], exc)
    return 0


if __name__ == '__main__':
    sys.exit(main())
