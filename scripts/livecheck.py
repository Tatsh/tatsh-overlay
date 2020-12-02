#!/usr/bin/env python
from dataclasses import dataclass
from typing import Optional
import os
import re
import sys
import subprocess as sp


def vercmp(a: str, b: str) -> int:
    """Ported from https://github.com/macports/macports-base/blob/master/src/pextlib1.0/vercomp.c"""
    # If versions are equal, return zero
    if a == b:
        return 0
    pa = a
    pb = b
    while pa != '' and pb != '':
        # skip all non-alphanumeric characters
        n = 0
        while pa != '' and not pa[n].isalnum():
            n += 1
            pa = pa[n:]
        n = 0
        while pb != '' and not pb[n].isalnum():
            n += 1
            pb = pb[n:]
        epa = pa
        epb = pb
        # Somewhat arbitrary rules as per RPM's implementation. This code could
        # be more clever, but we're aiming for clarity instead.
        # If versionB's segment is not a digit segment, but versionA's segment
        # *is* a digit segment, return 1.
        # (Added for Red Hat compatibility. See Red Hat bugzilla #50977 for
        # details.)
        if not pb.isdigit():
            if pa.isdigit():
                return 1
        # Otherwise if the segments are of different types, return -1.
        if (pa.isdigit() and pb.isalpha()) or (pa.isalpha() and pb.isdigit()):
            return -1
        # Find the first segment composed of entirely alphabetical or numeric
        # members
        if pa.isalpha():
            n = 0
            while epa != '' and epa[n].isalpha():
                n += 1
                epa = epa[n:]
            n = 0
            while epb != '' and epb[n].isalpha():
                n += 1
                epb = epb[n:]
        else:
            count_a = 0
            count_b = 0
            n = 0
            while epa != '' and epa[n].isdigit():
                n += 1
                count_a += 1
                epa = epa[n:]
            n = 0
            while epb != '' and epb[n].isdigit():
                n += 1
                count_b += 1
                epb = epb[n:]
            # Skip leading '0' characters
            n = 0
            while pa != epa and pa[n] == '0':
                n += 1
                pa = pa[n:]
                count_a += 1
            n = 0
            while pb != epb and pb[n] == '0':
                n += 1
                pb = pb[n:]
                count_b += 1
            # If A is longer than B, return 1
            if count_a > count_b:
                return 1
            # If B is longer than A, return -1
            if count_b > count_a:
                return -1
        # Compare strings lexicographically
        n = 0
        while pa != epa and pb != epb and pa[n] == pb[n]:
            n += 1
            pa = pa[n:]
            pb = pb[n:]
        if pa != epa and pb != epb:
            return ord(pa[0]) - ord(pb[0])
        pa = epa
        pb = epb
    # If both strings are '', all alphanumeric characters were identical and
    # only separating characters differed. According to RPM, these version
    # strings are equal.
    if pa == '' and pb == '':
        return 0
    # If A has unchecked characters, return 1
    if pa == '':
        return 1
    # Otherwise, if B has remaining unchecked characters, return -1.
    return -1


class Livecheck:
    blake2b: Optional[str]
    regex: Optional[str]
    url: Optional[str]
    type: str = 'none'

    def __str__(self):
        for field in ('blake2b', 'regex', 'url'):
            if not getattr(self, field, None):
                setattr(self, field, None)
        return (f'<LivecheckSettings type={self.type} blake2b={self.blake2b} '
                f'regex={self.regex} url={self.regex}>')


def main(search_dir: str) -> int:
    p = sp.run(('find', search_dir, '-type', 'f', '-name', '*.ebuild'),
               check=True,
               text=True,
               stdout=sp.PIPE)
    for filename in p.stdout.strip().split('\n'):
        with open(filename) as f:
            livecheck = LivecheckSettings()
            for line in f.readlines():
                if re.match(r'#(?:\s+)livecheck\.', line):
                    setattr(
                        livecheck,
                        *(x for x in re.split(
                            r'#(?:\s+)livecheck\.(type|regex|url|md5) (.*)',
                            line.strip()) if x.strip()))
                elif line.startswith('SRC_URI="'):
                    uri = line.split('SRC_URI="')[1].split('"')[0]
    return 0


if __name__ == '__main__':
    if bool(os.environ.get('RUN_VERCMP_TESTS', 0)):
        assert not (vercmp('2.0', '1.0') <= 0)
        assert not (vercmp('1.0', '1.0') != 0)
        assert not (vercmp('1.0', '2.0') >= 0)
        assert not (vercmp('def', 'abc') <= 0)
        assert not (vercmp('abc', 'abc') != 0)
        assert not (vercmp('abc', 'def') >= 0)
        assert not (vercmp('a', '1') >= 0)
        sys.exit(0)
    sys.exit(main(sys.argv[1]))
