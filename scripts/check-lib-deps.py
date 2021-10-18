#!/usr/bin/env python
from functools import lru_cache
from typing import Iterable, Iterator, Sequence, Tuple
import re
import subprocess as sp
import sys

import portage

P = portage.db[portage.root]['porttree'].dbapi


def is_elf(exe: str) -> bool:
    with open(exe, 'rb') as f:
        return f.read(4).endswith(b'ELF')


@lru_cache()
def qfile(filename: str) -> str:
    return sp.run(('qfile', filename),
                  check=True,
                  capture_output=True,
                  text=True).stdout


def find_missing_deps(package_name: str, libs: Iterable[str]) -> Iterator[str]:
    for x in libs:
        # Special case from forticlient
        if (package_name == 'net-vpn/forticlient' and x == 'libffmpeg.so'):
            continue
        if x.startswith('libudev.so'):
            lib_package = 'virtual/udev'
        elif x.startswith('libusb-'):
            lib_package = 'virtual/libusb'
        else:
            lines = qfile(x).splitlines()
            lib_package = [
                y for y in lines
                if '-libs/' in y or y.startswith('dev-qt/') or re.match(
                    r'^(?:app-pda/lib(?:irecovery|plist)|net-misc/curl|'
                    r'media-sound/(?:pulseaudio|mpg123)|media-video/ffmpeg|'
                    r'app-arch/(?:zstd|libarchive|lz4)|app-emulation/faudio|'
                    r'dev-util/glslang|net-wireless/bluez|sys-apps/dbus|'
                    r'app-accessibility/at-spi2-atk|net-print/cups|'
                    r'sys-apps/util-linux)', y)
            ][0].split(':')[0]
            if lib_package == package_name:
                continue
        ebuild = P.findname(P.match(package_name)[-1])
        with open(ebuild) as f:
            lines_s = f.read()
            if lib_package not in lines_s:
                yield lib_package


def find_missing_deps0(
        package_name: str,
        exes: Iterable[str]) -> Iterator[Tuple[str, Sequence[str]]]:
    for exe in exes:
        yield (
            exe,
            list(
                find_missing_deps(
                    package_name,
                    sorted(y for y in (
                        x.split()[1]
                        for x in sp.run(('objdump', '-p', exe),
                                        check=True,
                                        capture_output=True,
                                        text=True).stdout.splitlines()
                        if 'NEEDED' in x
                    ) if not re.match(
                        r'^lib(?:c|m|stdc\+\+|pthread|gcc_s|dl|asan|rt|util|'
                        r'gomp)\.so.\d+$', y)
                           and not y.startswith('ld-linux-')))))


def main() -> int:
    """
    This only works against packages installed and their configured USE flags.
    """
    if len(sys.argv) == 1:
        package_names = sp.run(('eix', '--installed-from-overlay',
                                'tatsh-overlay', '--only-names'),
                               check=True,
                               capture_output=True,
                               text=True).stdout.splitlines()
    else:
        package_names = sys.argv[1:]
    for package_name in package_names:
        printed_name = False
        exes = sorted(x for x in sp.run(('qlist', package_name),
                                        check=True,
                                        capture_output=True,
                                        text=True).stdout.splitlines()
                      if ('/bin/' in x or '/sbin/' in x) and is_elf(x))
        if len(exes):
            for exe, missing in find_missing_deps0(package_name, exes):
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
