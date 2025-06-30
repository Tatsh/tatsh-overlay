#!/usr/bin/env python
from functools import lru_cache
from typing import Iterable, Iterator, Tuple
import re
import subprocess as sp
import sys

import portage

P = portage.db[portage.root]['porttree'].dbapi

IGNORE = {
    'games-arcade/outfox': {
        'media-video/ffmpeg',
        'media-video/pipewire',  # ignored because virtual/jack is listed
        'virtual/libusb',
    },
    'games-arcade/stepmania': {'media-video/pipewire'},
    'games-emulation/xemu': {'media-video/pipewire'},
    'kde-misc/kate-wakatime': {'media-libs/libglvnd'},
}


def is_elf(exe: str) -> bool:
    try:
        with open(exe, 'rb') as f:
            return f.read(4).endswith(b'ELF')
    except (IsADirectoryError, FileNotFoundError, PermissionError):
        return False


@lru_cache()
def qfile(filename: str) -> str:
    return sp.run(('qfile', filename), check=True, capture_output=True, text=True).stdout


def find_missing_deps(package_name: str, libs: Iterable[str]) -> Iterator[str]:
    for x in libs:
        if x.startswith('libudev.so'):
            lib_package = 'virtual/udev'
        elif x.startswith('libusb-'):
            lib_package = 'virtual/libusb'
        else:
            try:
                lines = qfile(x).splitlines()
            except sp.CalledProcessError:
                continue
            try:
                lib_package = [
                    y for y in lines if ('-libs/' in y or y.startswith('dev-qt/')
                                         or y.startswith('dev-cpp/') or re.match(
                                             r'^(?:app-pda/lib(?:irecovery|plist)|net-misc/curl|'
                                             r'media-sound/(?:pulseaudio|mpg123)|'
                                             r'media-video/(ffmpeg|pipewire)|'
                                             r'app-arch/(?:zstd|libarchive|lz4)|'
                                             r'app-emulation/faudio|'
                                             r'dev-util/glslang|net-wireless/bluez|sys-apps/dbus|'
                                             r'app-accessibility/at-spi2-atk|net-print/cups|'
                                             r'sys-apps/util-linux|app-crypt/mit-krb5)', y))
                ][0].split(':')[0]
            except IndexError:
                continue
            if lib_package == package_name:
                continue
        try:
            ebuild = [
                y for y in (P.findname(x) for x in P.match(package_name)) if 'db/repos/tatsh' in y
            ][0]
        except IndexError:
            raise RuntimeError(f'Unable to determine ebuild for {package_name}')
        with open(ebuild) as f:
            lines_s = f.read()
            if lib_package not in lines_s and lib_package != 'sys-libs/glibc':
                yield lib_package


def find_missing_deps0(package_name: str, exes: Iterable[str]) -> Iterator[Tuple[str, list[str]]]:
    for exe in exes:
        yield (exe,
               list(
                   find_missing_deps(
                       package_name,
                       sorted(y for y in (x.split()[1] for x in sp.run(
                           ('objdump', '-p',
                            exe), check=True, capture_output=True, text=True).stdout.splitlines()
                                          if 'NEEDED' in x)
                              if not re.match(
                                  r'^lib(?:c|m|stdc\+\+|pthread|gcc_s|dl|asan|rt|util|'
                                  r'gomp)\.so.\d+$', y) and not y.startswith('ld-linux-')))))


def main() -> int:
    """
    This only works against packages installed and their configured USE flags.
    """
    package_names = sp.run(('eix', '--installed-from-overlay', 'tatsh-overlay', '--only-names'),
                           check=True,
                           capture_output=True,
                           text=True).stdout.splitlines() if len(sys.argv) == 1 else sys.argv[1:]
    for package_name in package_names:
        printed_name = False
        exes = sorted(x for x in sp.run(('qlist', '-e', f'{package_name}::tatsh-overlay'),
                                        check=True,
                                        capture_output=True,
                                        text=True).stdout.splitlines()
                      if is_elf(x) and not re.match(r'/usr/lib\d+/ryujinx/lib.*\.so$', x)
                      and not re.match(r'/opt/stepmania-outfox/lib.*\.so(?:\.\d+)?', x))
        if len(exes):
            for exe, missing in ((exe, [
                    y for y in m if not (package_name in IGNORE and y in IGNORE[package_name])
            ]) for exe, m in find_missing_deps0(package_name, exes)):
                if len(missing):
                    if not printed_name:
                        print(f'{package_name}:')
                        printed_name = True
                    print(f'  {exe}:')
                    for x in sorted(set(missing)):
                        print(f'\t{x}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
