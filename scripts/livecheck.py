#!/usr/bin/env python
from os.path import basename, dirname
from os.path import join as path_join
from os.path import realpath
from urllib.parse import urlparse
from typing import Dict, Iterator, Tuple, cast
import glob
import re
import sys

from portage.versions import catpkgsplit, vercmp
import portage
import requests

p = portage.db[portage.root]['porttree'].dbapi

CUSTOM_LIVECHECKS: Dict[str, Tuple[str, str, bool]] = {
    'dev-db/dbeaver-ce-bin':
    ('https://dbeaver.io/files/', r'"/files/([^/]+)/"', True),
    'games-arcade/clone-hero':
    ('https://clonehero.net/', r'"/releases/v([^"]+)"', True),
    'media-gfx/flash-player-projector':
    ('https://www.adobe.com/support/flashplayer/debug_downloads.html',
     'The latest versions are <span>([^<]+)</span>', True),
    'media-gfx/pngdefry': ('http://www.jongware.com/pngdefry.html',
                           r'; v([^ ]+), dated', True),
    'media-video/magewell-pro-capture':
    ('https://www.magewell.com/downloads/pro-capture',
     r'data-title="Pro Capture for Linux" data-version="([^"]+)"', True),
    'net-im/ripcord': ('https://cancel.fm/ripcord/', r'Ripcord Linux ([^ ]+) ',
                       True),
    'net-proxy/charles': ('https://www.charlesproxy.com/download/',
                          r'name="version" value="([^"]+)"', True),
    'sys-auth/fprintd': ('https://cgit.freedesktop.org/libfprint/fprintd/',
                         r"\?h=v([^']+)'", True),
    'x11-misc/mimeo': ('https://xyne.archlinux.ca/projects/mimeo/src/',
                       r'mimeo-([\d\.]+)\.tar\.xz\b', True),
}
GITHUB_BRANCHES = {'games-arcade/stepmania': '5_1-new'}
IGNORED_PACKAGES = {
    'app-cdr/cdi2nero', 'app-cdr/cdirip', 'media-sound/yamaha-xg-soundfont',
    'x11-themes/shere-khan-x'
}
PREFIX_RE = r'(^[^0-9]+)[0-9]'


def get_highest_matches(search_dir: str) -> Iterator[str]:
    for path in glob.glob(f'{search_dir}/**/*.ebuild', recursive=True):
        pkg_name = basename(dirname(path))
        category = basename(dirname(dirname(path)))
        matches = p.xmatch('match-visible', f'{category}/{pkg_name}')
        if not matches:
            continue
        yield matches[-1]


def get_props(
        search_dir: str
) -> Iterator[Tuple[str, str, str, str, str, str, bool]]:
    for match in sorted(set(get_highest_matches(search_dir))):
        cat, pkg, ebuild_version = catpkgsplit(match)[0:3]
        catpkg = '/'.join((cat, pkg))
        if catpkg in IGNORED_PACKAGES:
            continue
        if catpkg in CUSTOM_LIVECHECKS:
            yield cast(Tuple[str, str, str, str, str, str, bool],
                       (cat, pkg, ebuild_version, ebuild_version) +
                       CUSTOM_LIVECHECKS[catpkg])
            continue
        src_uris = p.aux_get(match, ['SRC_URI'])[0]
        src_uri = src_uris.split(' ')[0]
        if src_uri.startswith('https://github.com/'):
            parsed = urlparse(src_uri)
            github_homepage = ('https://github.com' +
                               '/'.join(parsed.path.split('/')[0:3]))
            filename = basename(parsed.path)
            version = re.split(r'\.(?:tar\.(?:gz|bz2)|zip)$', filename, 2)[0]
            if re.match(r'^[0-9a-f]{7,}$',
                        version) and not re.match('^[0-9a-f]{8}$', version):
                branch = (GITHUB_BRANCHES[catpkg]
                          if catpkg in GITHUB_BRANCHES else 'master')
                url = f'{github_homepage}/commits/{branch}.atom'
                regex = (r'<id>tag:github.com,2008:Grit::Commit/([0-9a-f]{' +
                         str(len(version)) + r'})[0-9a-f]*</id>')
                yield cat, pkg, ebuild_version, version, url, regex, False
            elif ('/releases/download/' in parsed.path
                  or '/archive/' in parsed.path):
                prefix = ''
                m = re.match(
                    PREFIX_RE,
                    filename) if '/archive/' in parsed.path else re.match(
                        PREFIX_RE, basename(dirname(parsed.path)))
                if m:
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
            parsed = urlparse(src_uri)
            filename = basename(parsed.path)
            home = p.aux_get(match, ['HOMEPAGE'])[0]
            pkg_re = pkg.replace('-', r'[-_]')
            regex = r'\b' + pkg_re + r'-([^"]+)\.tar\.gz'
            yield cat, pkg, ebuild_version, ebuild_version, home, regex, True
        else:
            home = p.aux_get(match, ['HOMEPAGE'])[0]
            raise RuntimeError(
                f'Not handled: {catpkg} (non-GitHub/PyPI), homepage: {home}, '
                f'SRC_URI: {src_uri}')


def main(search_dir: str) -> int:
    session = requests.Session()
    for cat, pkg, ebuild_version, version, url, regex, use_vercmp in get_props(
            search_dir):
        r = session.get(url)
        r.raise_for_status()
        try:
            top_hash = re.findall(regex, r.text)[0]
        except IndexError as e:
            print(
                f'{cat}/{pkg} error: re.findall({regex}, [contents of {url}])',
                file=sys.stderr)
            raise e
        try:
            if (use_vercmp
                    and vercmp(top_hash, version) > 0) or top_hash != version:
                print(
                    f'{cat}/{pkg}: {top_hash} > {version} ({ebuild_version})')
        except Exception as e:
            print(f'Exception while checking {cat}/{pkg}', file=sys.stderr)
            raise e

    return 0


if __name__ == '__main__':
    sys.exit(
        main(
            realpath(path_join(dirname(__file__), '..')
                     ) if len(sys.argv) < 2 else sys.argv[1]))
