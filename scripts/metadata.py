#!/usr/bin/env python
from glob import glob
from os.path import dirname, join as path_join, realpath
from typing import Dict
from urllib.parse import urlparse
import subprocess as sp
import sys

GLOBAL_CACHE: Dict[str, bool] = {}
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


def main() -> int:
    root = realpath(path_join(dirname(__file__), '..'))
    for pkg in set(dirname(x) for x in glob(f'{root}/**/*.ebuild', recursive=True)):
        metadata_xml = path_join(pkg, 'metadata.xml')
        try:
            with open(metadata_xml):
                continue
        except FileNotFoundError:
            metadata_xml = path_join(pkg, 'metadata.xml')
            words = []
            with open(glob(f'{pkg}/*.ebuild')[-1]) as ebuild_handle:
                in_iuse = False
                lines = ebuild_handle.readlines()
                for line in lines:
                    if line.startswith('IUSE="'):
                        in_iuse = True
                        words += line.split('="')[1].strip().replace('"', '').replace('+',
                                                                                      '').split(' ')
                        if line.strip().endswith('"'):
                            break
                    elif in_iuse:
                        words += line.strip().replace('+', '').replace('"', '').split(' ')
                        if line.strip().endswith('"'):
                            break
                homepage = None
                upstream = ''
                for line in lines:
                    if line.startswith('HOMEPAGE='):
                        homepage = line.split('="')[1].strip().replace('"', '').split(' ')[0]
                        break
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
                        upstream += ('\n\t<upstream>\n' + f'\t\t<remote-id type="{id_type}">' +
                                     value + '</remote-id>' + '\n\t</upstream>')
                words = sorted(x for x in words if x and not is_global_flag(x))
            with open(metadata_xml, 'w+') as m:
                use = (('\n\t<use>\n' + '\n'.join(f'\t\t<flag name="{name}"></flag>'
                                                  for name in words) +
                        '\n\t</use>\n') if words else '\n')
                m.write(TEMPLATE.format(USE=use, UPSTREAM=upstream))
    return 0


if __name__ == '__main__':
    sys.exit(main())
