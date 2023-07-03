#!/usr/bin/env python
from datetime import date
from os.path import dirname, join as path_join
from typing import Set
import argparse
import glob
import json
import re
import sys

EBUILD_TEMPLATE = '''# Copyright {year} Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="{description}"
HOMEPAGE="{homepage}"
YARN_PKGS=(
{yarn_pkgs}
)
yarn_set_globals
SRC_URI="${{YARN_SRC_URI}}"

LICENSE="{licenses}"
KEYWORDS="~amd64"

S="${{WORKDIR}}"

src_install() {{
\tyarn_src_install
\t# TODO Install symlink to main script here
\tfperms 0755 "/usr/$(get_libdir)/${{PN}}/node_modules/{package}/bin/${{PN}}.js"
\tdosym "../$(get_libdir)/${{PN}}/node_modules/{package}/bin/${{PN}}.js" "/usr/bin/${{PN}}"
}}'''
# From parse-package-name
# https://github.com/egoist/parse-package-name/blob/main/src/index.ts
RE_SCOPED = r'^"(@[a-z][^\/]+\/[^@\/]+)(?:@([^\/]+))?(\/.*)?"\:$'
RE_NON_SCOPED = r'^"?([a-z][^@\/]+)(?:@([^\/]+))?(\/.*)?"?\:$'


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument('package')
    parser.add_argument('yarn.lock')
    args = dict(parser.parse_args()._get_kwargs())  # pylint: disable=protected-access
    yarn_lock = args['yarn.lock']
    root_dir = dirname(yarn_lock)
    package = args['package']
    licenses: Set[str] = set()
    with open(yarn_lock) as f:
        yarn_pkgs: Set[str] = set()
        lines = f.readlines()
        for i, line in enumerate(lines):
            m = re.match(RE_SCOPED, line) or re.match(RE_NON_SCOPED, line)
            if not m:
                continue
            name = m.groups()[0]
            version = None
            if m := re.match(r'^version "([^"]+)"', lines[i + 1].strip()):
                version = m.groups()[0]
            assert version is not None
            yarn_pkgs.add(f'\t{name}-{version}')
        with open(path_join(root_dir, 'node_modules', package, 'package.json')) as j:
            data = json.load(j)
            if lic := data.get('license'):
                licenses.add(lic)
        for item in glob.iglob('./**/package.json', root_dir=root_dir, recursive=True):
            with open(path_join(root_dir, item)) as j:
                try:
                    dep_data = json.load(j)
                    if lic := dep_data.get('license'):
                        licenses.add(lic)
                except json.decoder.JSONDecodeError:
                    pass
        print(
            EBUILD_TEMPLATE.format(year=date.today().year,
                                   description=data.get('description', 'FIXME'),
                                   homepage=data.get('homepage',
                                                     f'https://www.npmjs.com/package/{package}'),
                                   yarn_pkgs='\n'.join(sorted(yarn_pkgs)),
                                   package=package,
                                   licenses=' '.join(sorted(licenses))))
    return 0


if __name__ == '__main__':
    sys.exit(main())
