#!/usr/bin/env python
from dataclasses import dataclass
from os.path import basename, dirname, join as path_join, realpath
from urllib.parse import urlparse
from typing import (Any, Dict, Final, Iterator, Sequence, Set, Tuple, Union,
                    cast)
import glob
import hashlib
import json
import re
import sys

from portage.versions import catpkgsplit, vercmp
import portage
import requests

PropTuple = Tuple[str, str, str, str, str, str, bool]
Response = Union['TextDataResponse', requests.Response]

P = portage.db[portage.root]['porttree'].dbapi
PREFIX_RE: Final[str] = r'(^[^0-9]+)[0-9]'
SEMVER_RE: Final[str] = (r'^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.'
                         r'(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]'
                         r'\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|'
                         r'\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+'
                         r'(?P<buildmetadata>[0-9a-zA-Z-]+'
                         r'(?:\.[0-9a-zA-Z-]+)*))?$')


def get_highest_matches(search_dir: str) -> Iterator[str]:
    for path in glob.glob(f'{search_dir}/**/*.ebuild', recursive=True):
        dn = dirname(path)
        if matches := P.xmatch('match-visible',
                               f'{basename(dirname(dn))}/{basename(dn)}'):
            yield matches[-1]


def catpkg_catpkgsplit(s: str) -> Tuple[str, str, str, str]:
    cat, pkg, ebuild_version = catpkgsplit(s)[0:3]
    return '/'.join((cat, pkg)), cat, pkg, ebuild_version


def chunks(l: Sequence[Any], n: int) -> Iterator[Sequence[Any]]:
    for i in range(0, len(l), n):
        yield l[i:i + n]


@dataclass
class LivecheckSettings:
    branches: Dict[str, str]
    checksum_livechecks: Set[str]
    custom_livechecks: Dict[str, Tuple[str, str, bool]]
    ignored_packages: Set[str]


def get_props(search_dir: str,
              settings: LivecheckSettings) -> Iterator[PropTuple]:
    for match in sorted(set(get_highest_matches(search_dir))):
        catpkg, cat, pkg, ebuild_version = catpkg_catpkgsplit(match)
        src_uri = P.aux_get(match, ['SRC_URI'])[0].split(' ')[0]
        if cat.startswith('acct-') or catpkg in settings.ignored_packages:
            continue
        elif catpkg in settings.custom_livechecks:
            yield cast(  # type: ignore[redundant-cast]
                PropTuple, (cat, pkg, ebuild_version, ebuild_version) +
                settings.custom_livechecks[catpkg])
        elif catpkg in settings.checksum_livechecks:
            manifest_file = path_join(search_dir, catpkg, 'Manifest')
            bn = basename(src_uri)
            found = False
            with open(manifest_file) as f:
                for line in f.readlines():
                    if not line.startswith('DIST '):
                        continue
                    fields_s = ' '.join(line.strip().split(' ')[-4:])
                    rest = line.replace(fields_s, '').strip()
                    filename = rest.replace(f' {rest.strip().split(" ")[-1]}',
                                            '')[5:]
                    m = re.match(
                        '^' + pkg +
                        r'-[0-9\.]+(?:_(?:alpha|beta|p)[0-9]+)?(tar\.gz|zip)',
                        filename)
                    if filename != bn and not m:
                        continue
                    found = True
                    r = requests.get(src_uri)
                    r.raise_for_status()
                    yield (cat, pkg, ebuild_version,
                           dict(
                               cast(Sequence[Tuple[str, str]],
                                    chunks(fields_s.split(' '), 2)))['SHA512'],
                           f'data:{hashlib.sha512(r.content).hexdigest()}',
                           r'^[0-9a-f]+$', False)
                    break
            if not found:
                home = P.aux_get(match, ['HOMEPAGE'])[0]
                raise RuntimeError(
                    f'Not handled: {catpkg} (checksum), homepage: {home}, '
                    f'SRC_URI: {src_uri}')
        elif src_uri.startswith('https://github.com/'):
            parsed = urlparse(src_uri)
            github_homepage = ('https://github.com' +
                               '/'.join(parsed.path.split('/')[0:3]))
            filename = basename(parsed.path)
            version = re.split(r'\.(?:tar\.(?:gz|bz2)|zip)$', filename, 2)[0]
            if (re.match(r'^[0-9a-f]{7,}$', version)
                    and not re.match('^[0-9a-f]{8}$', version)):
                branch = (settings.branches[catpkg]
                          if catpkg in settings.branches else 'master')
                yield (cat, pkg, ebuild_version, version,
                       f'{github_homepage}/commits/{branch}.atom',
                       (r'<id>tag:github.com,2008:Grit::Commit/([0-9a-f]{' +
                        str(len(version)) + r'})[0-9a-f]*</id>'), False)
            elif ('/releases/download/' in parsed.path
                  or '/archive/' in parsed.path):
                prefix = ''
                if (m := re.match(PREFIX_RE, filename)
                        if '/archive/' in parsed.path else re.match(
                            PREFIX_RE, basename(dirname(parsed.path)))):
                    prefix = m.group(1)
                url = f'{github_homepage}/tags'
                regex = f'archive/{prefix}' + r'([^"]+)\.tar\.gz'
                yield (cat, pkg, ebuild_version, ebuild_version, url, regex,
                       True)
            else:
                raise ValueError(f'Unhandled GitHub package: {catpkg}')
        elif src_uri.startswith('mirror://pypi/'):
            dist_name = src_uri.split('/')[4]
            yield (cat, pkg, ebuild_version, ebuild_version,
                   f'https://pypi.org/pypi/{dist_name}/json',
                   r'"version":"([^"]+)"[,\}]', True)
        elif src_uri.startswith('https://www.raphnet-tech.com/downloads/'):
            yield (cat, pkg, ebuild_version, ebuild_version,
                   P.aux_get(match, ['HOMEPAGE'])[0],
                   (r'\b' + pkg.replace('-', r'[-_]') + r'-([^"]+)\.tar\.gz'),
                   True)
        else:
            home = P.aux_get(match, ['HOMEPAGE'])[0]
            raise RuntimeError(
                f'Not handled: {catpkg} (non-GitHub/PyPI), homepage: {home}, '
                f'SRC_URI: {src_uri}')


def gather_settings(search_dir: str) -> LivecheckSettings:
    branches = {}
    checksum_livechecks = set()
    custom_livechecks = {}
    ignored_packages = set()
    for path in glob.glob(f'{search_dir}/**/livecheck.json', recursive=True):
        with open(path) as f:
            dn = dirname(path)
            catpkg = f'{basename(dirname(dn))}/{basename(dn)}'
            ls = json.load(f)
            if ls.get('type', None) == 'none':
                ignored_packages.add(catpkg)
            elif ls.get('type', None) == 'regex':
                custom_livechecks[catpkg] = (ls['url'], ls['regex'],
                                             ls.get('use_vercmp', True))
            elif ls.get('type', None) == 'checksum':
                checksum_livechecks.add(catpkg)
            if ls.get('branch', None):
                branches[catpkg] = ls['branch']
    return LivecheckSettings(branches, checksum_livechecks, custom_livechecks,
                             ignored_packages)


@dataclass
class TextDataResponse:
    text: str

    def raise_for_status(self) -> None:
        pass


def convert_version(s: str) -> str:
    if m := re.match(SEMVER_RE, s):
        gd = m.groupdict()
        if gd['buildmetadata']:
            raise ValueError('Build metadata not handled yet')
        if gd['prerelease'] or gd['buildmetadata']:
            return '{}.{}.{}_{}'.format(gd['major'], gd['minor'], gd['patch'],
                                        gd['prerelease'].replace('.', ''))
    return s


def main(search_dir: str) -> int:
    session = requests.Session()
    for cat, pkg, ebuild_version, version, url, regex, use_vercmp in get_props(
            search_dir, gather_settings(search_dir)):
        r: Response = (TextDataResponse(url[5:])
                       if url.startswith('data:') else session.get(url))
        try:
            r.raise_for_status()
            # Ignore beta/alpha/etc if semantic and coming from GitHub
            if (m := re.match(r'^\d+\.\d+\.\d+', version) and top_hash != version and regex.startswith('archive/')):
                regex = regex.replace(r'([^"]+)', r'(\d+\.\d+\.\d+)')
            top_hash = convert_version(re.findall(regex, r.text)[0])
            if ((use_vercmp and vercmp(top_hash, version, silent=0) > 0)
                    or top_hash != version):
                print(
                    f'{cat}/{pkg}: {version} ({ebuild_version}) -> {top_hash}')
        except Exception as e:
            print(f'Exception while checking {cat}/{pkg}', file=sys.stderr)
            raise e
    return 0


if __name__ == '__main__':
    sys.exit(
        main(
            realpath(path_join(dirname(__file__), '..')
                     ) if len(sys.argv) < 2 else sys.argv[1]))
