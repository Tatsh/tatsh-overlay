#!/usr/bin/env python
from pathlib import Path
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


def ebuild_path_to_cpv(ebuild: Path) -> str:
    """Convert an ebuild file path to a CPV string (category/package-version)."""
    return f'{ebuild.parent.parent.name}/{ebuild.stem}'


def get_repo_root(path: Path) -> str:
    """Resolve a local repo path to the portage-registered location via profiles/repo_name."""
    repo_name_file = path / 'profiles' / 'repo_name'
    if not repo_name_file.exists():
        return str(path)
    repo_name = repo_name_file.read_text().strip()
    try:
        return P.repositories[repo_name].location  # type: ignore[attr-defined, no-any-return]
    except KeyError:
        return str(path)


def main() -> int:
    root = Path(__file__).resolve().parent.parent
    mytree = get_repo_root(root)
    for pkg in {p.parent for p in root.rglob('*.ebuild')}:
        metadata_xml = pkg / 'metadata.xml'
        if metadata_xml.exists():
            continue
        ebuilds = sorted(pkg.glob('*.ebuild'))
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
        with metadata_xml.open('w') as m:
            use = (('\n\t<use>\n' + '\n'.join(f'\t\t<flag name="{name}"></flag>'
                                              for name in words) +
                    '\n\t</use>\n') if words else '\n')
            m.write(TEMPLATE.format(USE=use, UPSTREAM=upstream))
    return 0


if __name__ == '__main__':
    sys.exit(main())
