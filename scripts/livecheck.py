#!/usr/bin/env python
from dataclasses import dataclass
from functools import cmp_to_key, lru_cache
from os.path import basename, dirname, join as path_join, realpath, splitext
from os.path import expanduser
from typing import (Any, Callable, Dict, Final, Iterator, Mapping, Optional,
                    Sequence, Set, Tuple, TypeVar, Union, cast)
from urllib.parse import urlparse
import argparse
import glob
import hashlib
import json
import logging
import re
import subprocess as sp
import sys
import xml.etree.ElementTree as etree

from portage.versions import catpkgsplit, vercmp
from requests import ConnectTimeout, ReadTimeout
import portage
import requests
import yaml

PropTuple = Tuple[str, str, str, str, str, Optional[str], bool]
Response = Union['TextDataResponse', requests.Response]
T = TypeVar('T')

LOG_NAME: Final[str] = 'livecheck'
P = portage.db[portage.root]['porttree'].dbapi
PREFIX_RE: Final[str] = r'(^[^0-9]+)[0-9]'
RSS_NS = {'': 'http://www.w3.org/2005/Atom'}
SEMVER_RE: Final[str] = (r'^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.'
                         r'(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]'
                         r'\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|'
                         r'\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+'
                         r'(?P<buildmetadata>[0-9a-zA-Z-]+'
                         r'(?:\.[0-9a-zA-Z-]+)*))?$')

SUBMODULES: Final[Mapping[str, Set[Union[str, Tuple[str, str]]]]] = {
    'app-misc/tasksh': {'src/libshared'},
    'app-pda/tsschecker': {'external/jssy'},
    'games-emulation/citra': {
        'externals/dynarmic',
        'externals/fmt',
        'externals/lodepng/lodepng',
        'externals/soundtouch',
        'externals/xbyak',
    },
    'games-emulation/play': {
        'deps/CodeGen',
        'deps/Dependencies',
        'deps/Framework',
        'deps/Nuanceur',
        'deps/libchdr',
    },
    'games-emulation/rpcs3': {
        '3rdparty/asmjit/asmjit',
        '3rdparty/hidapi',
        '3rdparty/yaml-cpp',
        'llvm',
    },
    'games-emulation/xemu': {
        'slirp',
        'ui/imgui',
        'ui/implot',
        'ui/keycodemapdb',
        ('tests/fp/berkeley-softfloat-3', 'SOFTFLOAT_SHA'),
        ('tests/fp/berkeley-testfloat-3', 'TESTFLOAT_SHA'),
    },
    'games-emulation/yuzu': {
        'externals/SDL',
        'externals/dynarmic',
        'externals/sirit',
        'externals/soundtouch',
        ('externals/cpp-httplib', 'HTTPLIB_SHA'),
    },
    'media-sound/sony-headphones-client': {'Client/imgui'},
}
TAG_NAME_FUNCTIONS: Final[Mapping[str, Callable[[str], str]]] = {
    'app-misc/tasksh': lambda s: f'v{s}',
    'games-emulation/rpcs3': lambda s: f'v{s}',
    'games-emulation/xemu': lambda s: f'xemu-v{s}',
    'games-emulation/yuzu': lambda x: f'mainline-{x.replace(".", "-")}',
    'media-sound/sony-headphones-client': lambda s: f'v{s}',
}


@lru_cache()
def get_github_api_credentials() -> str:
    with open(expanduser('~/.config/gh/hosts.yml')) as f:
        data = yaml.safe_load(f)
    return data['github.com']['oauth_token']


def process_submodules(pkg_name: str, ref: str, contents: str,
                       repo_uri: str) -> str:
    if pkg_name not in SUBMODULES:
        return contents
    repo_root = '/'.join([''] + urlparse(repo_uri).path.split('/')[1:3])
    ebuild_lines = contents.splitlines(keepends=True)
    for item in SUBMODULES[pkg_name]:
        name = item
        if isinstance(item, tuple):
            grep_for = f'{item[1]}="'
            name = item[0]
        else:
            grep_for = f"{basename(item).upper().replace('-', '_')}_SHA=\""
        r = requests.get(
            (f'https://api.github.com/repos{repo_root}/contents/{name}'
             f'?ref={ref}'),
            headers=dict(
                Authorization=f'token {get_github_api_credentials()}'))
        r.raise_for_status()
        remote_sha = r.json()['sha']
        for line in ebuild_lines:
            if line.startswith(grep_for):
                local_sha = line.split('=')[1].replace('"', '').strip()
                if local_sha != remote_sha:
                    contents = contents.replace(local_sha, remote_sha)
    return contents


def get_highest_matches(search_dir: str) -> Iterator[str]:
    for path in glob.glob(f'{search_dir}/**/*.ebuild', recursive=True):
        dn = dirname(path)
        if matches := P.xmatch('match-visible',
                               f'{basename(dirname(dn))}/{basename(dn)}'):
            yield matches[-1]


def get_highest_matches2(names: Sequence[str]) -> Iterator[str]:
    for name in names:
        if matches := P.xmatch('match-visible', name):
            yield matches[-1]


def catpkg_catpkgsplit(s: str) -> Tuple[str, str, str, str]:
    cat, pkg, ebuild_version = catpkgsplit(s)[0:3]
    return '/'.join((cat, pkg)), cat, pkg, ebuild_version


def chunks(l: Sequence[Any], n: int) -> Iterator[Sequence[Any]]:
    for i in range(0, len(l), n):
        yield l[i:i + n]


def get_first_src_uri(match: str) -> str:
    return P.aux_get(match, ['SRC_URI'])[0].split(' ')[0]


@dataclass
class LivecheckSettings:
    branches: Dict[str, str]
    checksum_livechecks: Set[str]
    custom_livechecks: Dict[str, Tuple[str, str, bool, str]]
    ignored_packages: Set[str]
    no_auto_update: Set[str]
    transformations: Mapping[str, Callable[[str], str]]


def is_sha(s: str) -> bool:
    return bool((len(s) == 7 or len(s) > 8) and re.match(r'^[0-9a-f]+$', s))


def dotize(s: str) -> str:
    ret = s.replace('-', '.').replace('_', '.')
    logging.getLogger(LOG_NAME).debug('dotize(): %s -> %s', s, ret)
    return ret


def get_props(search_dir: str,
              settings: LivecheckSettings,
              names: Optional[Sequence[str]] = None,
              exclude: Optional[Sequence[str]] = None) -> Iterator[PropTuple]:
    log = logging.getLogger(LOG_NAME)
    log.debug('get_props(): search_dir=%s', search_dir)
    exclude = exclude or []
    for match in sorted(
            set(
                get_highest_matches(search_dir)
                if not names else get_highest_matches2(names))):
        catpkg, cat, pkg, ebuild_version = catpkg_catpkgsplit(match)
        if catpkg in exclude or pkg in exclude:
            log.debug('Ignoring %s', catpkg)
            continue
        src_uri = get_first_src_uri(match)
        if cat.startswith('acct-') or catpkg in settings.ignored_packages:
            continue
        elif catpkg in settings.custom_livechecks:
            url, regex, use_vercmp, version = settings.custom_livechecks[
                catpkg]
            yield (cat, pkg, version or ebuild_version, version
                   or ebuild_version, url, regex, use_vercmp)
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
            log.debug('Parsed path: %s', parsed.path)
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
                regex = f'archive/refs/tags/{prefix}' + r'([^"]+)\.tar\.gz'
                yield (cat, pkg, ebuild_version, ebuild_version, url, regex,
                       True)
            elif m := re.search(r'/raw/([0-9a-f]+)/', parsed.path):
                version = m.group(1)
                branch = (settings.branches[catpkg]
                          if catpkg in settings.branches else 'master')
                yield (cat, pkg, ebuild_version, version,
                       f'{github_homepage}/commits/{branch}.atom',
                       (r'<id>tag:github.com,2008:Grit::Commit/([0-9a-f]{' +
                        str(len(version)) + r'})[0-9a-f]*</id>'), False)
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
        elif 'download.jetbrains.com' in src_uri:
            yield (cat, pkg, ebuild_version, ebuild_version,
                   'https://www.jetbrains.com/updates/updates.xml', None, True)
        else:
            home = P.aux_get(match, ['HOMEPAGE'])[0]
            raise RuntimeError(
                f'Not handled: {catpkg} (non-GitHub/PyPI), homepage: {home}, '
                f'SRC_URI: {src_uri}')


def gather_settings(search_dir: str) -> LivecheckSettings:
    log = logging.getLogger(LOG_NAME)
    branches = {}
    checksum_livechecks = set()
    custom_livechecks = {}
    ignored_packages = set()
    no_auto_update = set()
    transformations = {}
    for path in glob.glob(f'{search_dir}/**/livecheck.json', recursive=True):
        log.debug('Opening %s', path)
        with open(path) as f:
            dn = dirname(path)
            catpkg = f'{basename(dirname(dn))}/{basename(dn)}'
            ls = json.load(f)
            if ls.get('type', None) == 'none':
                ignored_packages.add(catpkg)
            elif ls.get('type', None) == 'regex':
                custom_livechecks[catpkg] = (ls['url'], ls['regex'],
                                             ls.get('use_vercmp', True),
                                             ls.get('version', None))
            elif ls.get('type', None) == 'checksum':
                checksum_livechecks.add(catpkg)
            if ls.get('branch', None):
                branches[catpkg] = ls['branch']
            if ls.get('no_auto_update', None):
                no_auto_update.add(catpkg)
            if ls.get('transformation_function', None):
                tf = ls['transformation_function']
                if tf == 'dotize':
                    transformations[catpkg] = dotize
                elif tf == 'handle_stepmania_outfox':
                    transformations[catpkg] = handle_stepmania_outfox
                elif tf == 'handle_re':
                    transformations[catpkg] = handle_re
                elif tf == 'handle_bsnes_hd':
                    transformations[catpkg] = handle_bsnes_hd
                elif tf == 'handle_glabels':
                    transformations[catpkg] = handle_glabels
                elif tf == 'handle_cython_post_suffix':
                    transformations[catpkg] = handle_cython_post_suffix
                else:
                    raise Exception(f'Unknown transformation function: {tf}')
    return LivecheckSettings(branches, checksum_livechecks, custom_livechecks,
                             ignored_packages, no_auto_update, transformations)


@dataclass
class TextDataResponse:
    text: str

    def raise_for_status(self) -> None:
        pass


def handle_glabels(s: str) -> str:
    r = requests.get(
        f'https://github.com/jimevins/glabels-qt/commits/glabels-{s}.atom')
    r.raise_for_status()
    return ('3.99_p' + assert_not_none(
        assert_not_none(
            etree.fromstring(r.text).find(
                'entry/updated', RSS_NS)).text).split('T')[0].replace('-', ''))


def handle_stepmania_outfox(s: str) -> str:
    log = logging.getLogger(LOG_NAME)
    log.debug('handle_stepmania_outfox() <- "%s"', s)
    s = re.sub(r'[^0-9\.]+', '', s)
    ret = f'5.3.0.{s}_alpha'
    log.debug('handle_stepmania_outfox() -> "%s"', ret)
    return ret


def handle_re(s: str) -> str:
    return re.sub(r'^re(3|VC|LCS)_v?', '', s)


def handle_cython_post_suffix(s: str) -> str:
    return s.replace('.post', '.')


def assert_not_none(x: Optional[T]) -> T:
    assert x is not None
    return x


def handle_bsnes_hd(s: str) -> str:
    log = logging.getLogger(LOG_NAME)
    log.debug('handle_bsnes_hd() <- "%s"', s)
    major, minor = assert_not_none(re.match(r'^beta_(\d+)_(\d+(?:h\d+)?)',
                                            s)).groups()
    minor = re.sub(r'h\d+', '', minor)
    ret = f'{major}.{minor}_beta'
    log.debug('handle_bsnes_hd() -> "%s"', ret)
    return ret


def setup_logging_stderr(name: Optional[str] = LOG_NAME,
                         verbose: bool = False) -> logging.Logger:
    name = name if name else basename(sys.argv[0])
    log = logging.getLogger(name)
    log.setLevel(logging.DEBUG if verbose else logging.INFO)
    channel = logging.StreamHandler(sys.stdout)
    channel.setFormatter(logging.Formatter('%(levelname)s - %(message)s'))
    channel.setLevel(logging.DEBUG if verbose else logging.INFO)
    log.addHandler(channel)
    return log


def latest_jetbrains_versions(xml_content: str,
                              product_name: str) -> Iterator[Dict[str, str]]:
    return (dict(version=z.attrib['version'],
                 fullNumber=z.attrib['fullNumber']) for z in [
                     y for y in [
                         x for x in etree.fromstring(xml_content)
                         if x.attrib.get('name') == product_name
                     ][0] if y.attrib.get('status') == 'release'
                 ][0])


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument('-a', '--auto-update', action='store_true')
    parser.add_argument('-D',
                        '--directory',
                        nargs=1,
                        default=realpath(path_join(dirname(__file__), '..')))
    parser.add_argument('-d', '--debug', action='store_true')
    parser.add_argument('-e', '--exclude', nargs='*')
    parser.add_argument('package_names', nargs='*')
    args = parser.parse_args()
    log = setup_logging_stderr('livecheck', verbose=args.debug)
    if args.exclude:
        log.debug('Excluding %s', ', '.join(args.exclude))
    search_dir = args.directory
    session = requests.Session()
    settings = gather_settings(search_dir)
    for cat, pkg, ebuild_version, version, url, regex, use_vercmp in get_props(
            search_dir, settings, names=args.package_names,
            exclude=args.exclude):
        log.debug('Fetching %s', url)
        try:
            r: Response = (TextDataResponse(url[5:]) if url.startswith('data:')
                           else session.get(url, timeout=30))
        except (ReadTimeout, ConnectTimeout, requests.exceptions.HTTPError,
                requests.exceptions.SSLError) as e:
            log.debug('Caught error %s attempting to fetch %s', e, url)
            continue
        try:
            r.raise_for_status()
            # Ignore beta/alpha/etc if semantic and coming from GitHub
            if regex and re.match(SEMVER_RE,
                                  version) and regex.startswith('archive/'):
                log.debug('Adjusting RE for semantic versioning')
                regex = regex.replace(r'([^"]+)', r'(\d+\.\d+(?:\.\d+)?)')
            prefixes = cast(Optional[Dict[str, str]], None)
            if not regex:
                if 'www.jetbrains.com/updates' in url:
                    if pkg.startswith('idea'):
                        jb_versions = list(
                            latest_jetbrains_versions(r.text, 'IntelliJ IDEA'))
                        results = [x['fullNumber'] for x in jb_versions]
                        prefixes = dict((z['fullNumber'], f"{z['version']}.")
                                        for z in jb_versions)
                    else:
                        raise NotImplementedError(
                            'Unhandled state: '
                            f'regex=None, cat={cat}, pkg={pkg}, url={url}')
                else:
                    raise NotImplementedError(
                        'Unhandled state: non-JetBrains URI, regex=None, '
                        f'url={url}, cat={cat}, pkg={pkg}')
            else:
                log.debug('Using RE: "%s"', regex)
                results = re.findall(regex, r.text)
            top_hash = (list(
                reversed(
                    sorted(results,
                           key=cmp_to_key(
                               cast(
                                   Callable[[str, str],
                                            int], lambda x, y: -1 if
                                   (ret := vercmp(x, y)) is None else ret)))))
                        if use_vercmp else results)[0]
            log.debug('re.findall() -> "%s"', top_hash)
            cp = f'{cat}/{pkg}'
            if tf := settings.transformations.get(cp, None):
                top_hash = tf(top_hash)
            if cp == 'games-emulation/play':
                top_hash = top_hash.replace('-', '.')
            if prefixes:
                assert top_hash in prefixes
                top_hash = f'{prefixes[top_hash]}{top_hash}'
            log.debug(
                'Comparing current ebuild version %s with live version %s',
                version, top_hash)
            assert isinstance(use_vercmp, bool)
            if ((use_vercmp and vercmp(top_hash, version, silent=0) > 0)
                    or top_hash != version):
                if args.auto_update and cp not in settings.no_auto_update:
                    ebuild = P.findname(P.match(cp)[-1])
                    with open(ebuild, 'r') as f:
                        old_content = f.read()
                    content = old_content.replace(version, top_hash)
                    if cp == 'games-emulation/ryujinx':
                        commit = cast(requests.Response,
                                      r).json()['build']['commitId']
                        content = re.sub(r'^SHA="[^"]+"', f'SHA="{commit}"',
                                         content, 1, re.MULTILINE)
                    ps_ref = top_hash
                    if not is_sha(top_hash) and cp in TAG_NAME_FUNCTIONS:
                        ps_ref = TAG_NAME_FUNCTIONS[cp](top_hash)
                    content = process_submodules(cp, ps_ref, content, url)
                    dn = dirname(ebuild)
                    new_filename = f'{dn}/{pkg}-{top_hash}.ebuild'
                    if is_sha(top_hash):
                        updated_el = etree.fromstring(r.text).find(
                            'entry/updated', RSS_NS)
                        assert updated_el is not None
                        assert updated_el.text is not None
                        if re.search(r'(2[0-9]{7})', ebuild_version):
                            new_date = updated_el.text.split('T')[0].replace(
                                '-', '')
                            ebuild_version = re.sub(r'2[0-9]{7}', new_date,
                                                    ebuild_version)
                            new_filename = (f'{dn}/{pkg}-{ebuild_version}'
                                            '.ebuild')
                    if ebuild == new_filename:
                        name, ext = splitext(ebuild)
                        new_filename = f'{name}-r1{ext}'
                    print(f'Renaming {ebuild} -> {new_filename}')
                    sp.run(('git', 'mv', ebuild, new_filename), check=True)
                    with open(new_filename, 'w') as f:
                        f.write(content)
                else:
                    new_date = ''
                    if is_sha(top_hash):
                        updated_el = etree.fromstring(r.text).find(
                            'entry/updated', RSS_NS)
                        assert updated_el is not None
                        assert updated_el.text is not None
                        if m := re.search(r'(2[0-9]{7})', ebuild_version):
                            new_date = (' (' + ebuild_version[:m.span()[0]] +
                                        updated_el.text.split('T')[0].replace(
                                            '-', '') + ')')
                    print(f'{cat}/{pkg}: {version} ({ebuild_version}) -> '
                          f'{top_hash}{new_date}')
        except (requests.exceptions.HTTPError,
                requests.exceptions.SSLError) as e:
            log.warning('Caught error while checking %s/%s: %s', cat, pkg, e)
        except Exception as e:
            print(f'Exception while checking {cat}/{pkg}', file=sys.stderr)
            raise e
    return 0


if __name__ == '__main__':
    sys.exit(main())
