#!/usr/bin/env python
"""For each ebuild in Phase 1, fetch upstream pyproject.toml and classify test deps.

Reads ``tests-audit.csv`` produced by :mod:`audit_tests` and emits a per-ebuild
report describing whether the ebuild can be wired with a simple
``distutils_enable_tests pytest`` or whether it needs extra ``BDEPEND`` entries
or ``RESTRICT="test"``.

The classification is heuristic and exists to accelerate human review — every
emitted recommendation is a starting point, not a final answer.
"""
from __future__ import annotations

from collections.abc import Iterable
from functools import lru_cache
from pathlib import Path
import argparse
import csv
import json
import logging
import os
import re
import sys
import time
import tomllib

import requests

logger = logging.getLogger('upstream_test_deps')

GITHUB_RAW = 'https://raw.githubusercontent.com'
USER_AGENT = 'tatsh-overlay-audit/1.0'
CACHE_DIR = Path(os.environ.get('XDG_CACHE_HOME', str(
    Path.home() / '.cache'))) / 'tatsh-overlay-audit'
GENTOO_REPO = Path('/var/db/repos/gentoo')

# Common pytest plugins / test deps to PN mapping (ebuild package name).
# Empty value means "no Gentoo equivalent known".
KNOWN_PACKAGE_MAP = {
    'pytest': 'dev-python/pytest',
    'pytest-asyncio': 'dev-python/pytest-asyncio',
    'pytest-mock': 'dev-python/pytest-mock',
    'pytest-cov': 'dev-python/pytest-cov',
    'pytest-xdist': 'dev-python/pytest-xdist',
    'pytest-benchmark': 'dev-python/pytest-benchmark',
    'pytest-trio': 'dev-python/pytest-trio',
    'pytest-anyio': '',
    'pytest-httpserver': 'dev-python/pytest-httpserver',
    'pytest-httpx': 'dev-python/pytest-httpx',
    'pytest-rerunfailures': 'dev-python/pytest-rerunfailures',
    'pytest-recording': '',
    'pytest-vcr': '',
    'pytest-timeout': 'dev-python/pytest-timeout',
    'pytest-subtests': 'dev-python/pytest-subtests',
    'pytest-instafail': 'dev-python/pytest-instafail',
    'pytest-repeat': 'dev-python/pytest-repeat',
    'requests-mock': 'dev-python/requests-mock',
    'responses': 'dev-python/responses',
    'respx': 'dev-python/respx',
    'mock': 'dev-python/mock',
    'hypothesis': 'dev-python/hypothesis',
    'numpy': 'dev-python/numpy',
    'cython': 'dev-python/cython',
    'trustme': 'dev-python/trustme',
}


def _cache_path(name: str) -> Path:
    return CACHE_DIR / re.sub(r'[^A-Za-z0-9._-]+', '_', name)


@lru_cache(maxsize=4096)
def gentoo_has(category_pn: str) -> bool:
    """Check whether ``category/pn`` exists in the main Gentoo repo or this overlay."""
    if not category_pn:
        return False
    if (GENTOO_REPO / category_pn).is_dir():
        return True
    overlay = Path(__file__).resolve().parent.parent
    if (overlay / category_pn).is_dir():
        return True
    return False


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
    except requests.RequestException as exc:
        logger.warning('fetch failed %s: %s', url, exc)
        return None
    if not resp.ok:
        return None
    cache.parent.mkdir(parents=True, exist_ok=True)
    cache.write_text(resp.text)
    return resp.text


def extract_test_deps(pyproject_text: str) -> list[str]:
    """Extract candidate test dependency names from a pyproject.toml.

    Looks across modern dep-group conventions and returns bare distribution
    names (``pytest``, ``pytest-asyncio`` …) without version constraints.
    """
    try:
        data = tomllib.loads(pyproject_text)
    except tomllib.TOMLDecodeError:
        logger.warning('invalid toml')
        return []
    out: list[str] = []

    def _add_from_mapping(deps: dict[str, object]) -> None:
        for name in deps:
            if isinstance(name, str):
                out.append(name)

    def _add_from_list(deps: list[object]) -> None:
        for spec in deps:
            if isinstance(spec, str):
                m = re.match(r'([A-Za-z0-9_.-]+)', spec)
                if m:
                    out.append(m.group(1))

    poetry = data.get('tool', {}).get('poetry', {}) if isinstance(data.get('tool'), dict) else {}
    if isinstance(poetry, dict):
        groups = poetry.get('group', {})
        if isinstance(groups, dict):
            for group_name, group_val in groups.items():
                if not isinstance(group_val, dict):
                    continue
                if group_name not in {'dev', 'test', 'tests', 'testing'}:
                    continue
                deps = group_val.get('dependencies')
                if isinstance(deps, dict):
                    _add_from_mapping(deps)
        dev_deps = poetry.get('dev-dependencies')
        if isinstance(dev_deps, dict):
            _add_from_mapping(dev_deps)
    project = data.get('project', {})
    if isinstance(project, dict):
        opt = project.get('optional-dependencies', {})
        if isinstance(opt, dict):
            for group_name, group_val in opt.items():
                if group_name.lower() in {'test', 'tests', 'testing', 'dev'}:
                    if isinstance(group_val, list):
                        _add_from_list(group_val)
    dep_groups = data.get('dependency-groups', {})
    if isinstance(dep_groups, dict):
        for group_name, group_val in dep_groups.items():
            if group_name.lower() in {'test', 'tests', 'testing', 'dev'}:
                if isinstance(group_val, list):
                    _add_from_list(group_val)
    hatch = data.get('tool', {}).get('hatch', {})
    if isinstance(hatch, dict):
        envs = hatch.get('envs', {})
        if isinstance(envs, dict):
            for env_name, eval_ in envs.items():
                if not isinstance(eval_, dict):
                    continue
                if env_name.lower() not in {'default', 'test', 'tests', 'dev'}:
                    continue
                deps = eval_.get('dependencies')
                if isinstance(deps, list):
                    _add_from_list(deps)
    pdm = data.get('tool', {}).get('pdm', {})
    if isinstance(pdm, dict):
        dev_deps = pdm.get('dev-dependencies', {})
        if isinstance(dev_deps, dict):
            for group_name, group_val in dev_deps.items():
                if group_name.lower() in {'test', 'tests', 'testing', 'dev'}:
                    if isinstance(group_val, list):
                        _add_from_list(group_val)
    seen: set[str] = set()
    deduped = []
    for d in out:
        norm = d.lower().replace('_', '-')
        if norm in seen:
            continue
        seen.add(norm)
        deduped.append(norm)
    return deduped


def classify(deps: Iterable[str]) -> dict[str, list[str]]:
    """Bucket the deps into known/unknown."""
    known: list[str] = []
    unknown: list[str] = []
    irrelevant_prefixes = ('mypy', 'ruff', 'flake8', 'black', 'pylint', 'pylama', 'isort', 'yapf',
                           'coverage', 'coveralls', 'tox', 'nox', 'pre-commit', 'sphinx', 'twine',
                           'build', 'setuptools', 'wheel', 'pyproject-', 'poetry')
    for d in deps:
        if d.startswith(irrelevant_prefixes):
            continue
        cat_pn = KNOWN_PACKAGE_MAP.get(d)
        if cat_pn is None:
            unknown.append(d)
            continue
        if cat_pn == '':
            unknown.append(d)
            continue
        if gentoo_has(cat_pn):
            known.append(cat_pn)
        else:
            unknown.append(d)
    return {'known': sorted(set(known)), 'unknown': sorted(set(unknown))}


def main() -> int:
    """Walk the audit CSV and emit upstream test-dep classification."""
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--csv', default='tests-audit.csv')
    ap.add_argument('--output', default='phase1-classification.json')
    ap.add_argument('--token', default=os.environ.get('GITHUB_TOKEN'))
    ap.add_argument('-v', '--verbose', action='count', default=0)
    args = ap.parse_args()

    log_level = logging.WARNING
    if args.verbose >= 2:
        log_level = logging.DEBUG
    elif args.verbose == 1:
        log_level = logging.INFO
    logging.basicConfig(level=log_level,
                        format='%(asctime)s %(levelname)s %(name)s %(message)s',
                        stream=sys.stderr)

    overlay_root = Path(__file__).resolve().parent.parent
    csv_path = overlay_root / args.csv
    with csv_path.open() as f:
        rows = list(csv.DictReader(f))

    work = [
        r for r in rows if r['has_tests'] == 'true' and r['already_enabled'] == 'false'
        and r['build_system'] in {'python', 'python-single', 'python-multi'}
    ]
    logger.info('classifying %d ebuilds', len(work))

    out: dict[str, dict[str, object]] = {}
    for r in work:
        ref_full = r['upstream_ref']
        if '@' not in ref_full:
            continue
        repo, ref = ref_full.rsplit('@', 1)
        if '/' not in repo:
            continue
        owner, name = repo.split('/', 1)
        py = fetch_pyproject(owner, name, ref, args.token)
        if py is None:
            out[r['ebuild']] = {'status': 'no-pyproject', 'known': [], 'unknown': []}
            continue
        deps = extract_test_deps(py)
        cls = classify(deps)
        recommendation = 'simple'
        if cls['unknown']:
            recommendation = 'restrict-or-deselect'
        elif cls['known']:
            recommendation = 'with-bdepend'
        out[r['ebuild']] = {
            'upstream': ref_full,
            'all_deps': deps,
            'known': cls['known'],
            'unknown': cls['unknown'],
            'recommendation': recommendation,
        }
        time.sleep(0.05)

    out_path = overlay_root / args.output
    out_path.write_text(json.dumps(out, indent=2, sort_keys=True) + '\n')
    print(f'\nWrote classification for {len(out)} ebuilds to {out_path}', file=sys.stderr)
    print('\n--- Summary ---', file=sys.stderr)
    summary: dict[str, int] = {}
    for v in out.values():
        rec = str(v.get('recommendation', 'unknown'))
        summary[rec] = summary.get(rec, 0) + 1
    for k, count in sorted(summary.items()):
        print(f'  {k}: {count}', file=sys.stderr)
    return 0


if __name__ == '__main__':
    sys.exit(main())
