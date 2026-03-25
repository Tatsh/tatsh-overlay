#!/usr/bin/env python
from glob import glob
from os.path import basename, dirname, exists, join as path_join, realpath
from urllib.parse import urlparse
import subprocess as sp
import sys

import portage

GLOBAL_CACHE: dict[str, bool] = {}
P = portage.db[portage.root]['porttree'].dbapi
USE_EXPAND_PREFIXES = tuple(
    x.lower() + '_'
    for x in portage.settings.get('USE_EXPAND', '').split())  # type: ignore[attr-defined]
TEMPLATE = '''<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE pkgmetadata SYSTEM "http://www.gentoo.org/dtd/metadata.dtd">
<pkgmetadata>
\t<maintainer type="person">
\t\t<email>audvare@gmail.com</email>
\t\t<name>Andrew Udvare</name>
\t</maintainer>{UPSTREAM}{USE}</pkgmetadata>
'''


def is_global_flag(name: str) -> bool:
    if name in GLOBAL_CACHE:
        return GLOBAL_CACHE[name]
    proc = sp.run(('quse', '-De', name), check=False, stdout=sp.PIPE, text=True)
    for line in proc.stdout.split('\n'):
        if line.startswith(f'global[{name}] '):
            GLOBAL_CACHE[name] = True
            return True
    GLOBAL_CACHE[name] = False
    return False


def ebuild_path_to_cpv(ebuild: str) -> str:
    """Convert an ebuild file path to a CPV string (category/package-version)."""
    # /path/to/overlay/cat/pkg/pkg-ver.ebuild -> cat/pkg-ver
    pkg_dir = dirname(ebuild)
    cat_dir = dirname(pkg_dir)
    category = basename(cat_dir)
    version_name = basename(ebuild).removesuffix('.ebuild')
    return f'{category}/{version_name}'


def get_repo_root(path: str) -> str:
    """Resolve a local repo path to the portage-registered location via profiles/repo_name."""
    repo_name_file = path_join(path, 'profiles', 'repo_name')
    if not exists(repo_name_file):
        return path
    with open(repo_name_file) as f:
        repo_name = f.read().strip()
    try:
        return P.repositories[repo_name].location  # type: ignore[attr-defined, no-any-return]
    except KeyError:
        return path


def main() -> int:
    root = realpath(path_join(dirname(__file__), '..'))
    mytree = get_repo_root(root)
    for pkg in set(dirname(x) for x in glob(f'{root}/**/*.ebuild', recursive=True)):
        metadata_xml = path_join(pkg, 'metadata.xml')
        if exists(metadata_xml):
            continue
        ebuilds = glob(f'{pkg}/*.ebuild')
        if not ebuilds:
            continue
        cpv = ebuild_path_to_cpv(ebuilds[-1])
        try:
            iuse_raw, homepage_raw = P.aux_get(cpv, ['IUSE', 'HOMEPAGE'], mytree=mytree)
        except KeyError:
            print(f'Warning: failed to get metadata for {cpv}, skipping.', file=sys.stderr)
            continue
        flags = []
        for token in iuse_raw.split():
            name = token.lstrip('+')
            if name and not name.startswith(USE_EXPAND_PREFIXES) and not is_global_flag(name):
                flags.append(name)
        words = sorted(flags)
        homepage = homepage_raw.split()[0] if homepage_raw.strip() else None
        upstream = ''
        if homepage:
            parsed = urlparse(homepage)
            id_type = None
            value = None
            if parsed.hostname == 'github.com':
                id_type = 'github'
                value = '/'.join(parsed.path.split('/')[-2:])
            elif parsed.hostname == 'pypi.org':
                id_type = 'pypi'
                value = parsed.path.strip('/').split('/')[-1]
            if id_type and value:
                upstream = ('\n\t<upstream>\n' + f'\t\t<remote-id type="{id_type}">' + value +
                            '</remote-id>' + '\n\t</upstream>')
        with open(metadata_xml, 'w+') as m:
            use = (('\n\t<use>\n' + '\n'.join(f'\t\t<flag name="{name}"></flag>'
                                              for name in words) +
                    '\n\t</use>\n') if words else '\n')
            m.write(TEMPLATE.format(USE=use, UPSTREAM=upstream))
    return 0


if __name__ == '__main__':
    sys.exit(main())
