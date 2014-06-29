#!/usr/bin/env python
from os.path import basename, join as path_join
import subprocess as sp
import sys

CLASS_MAP = {
    'd2j-apk-sign': 'com.googlecode.dex2jar.tools.ApkSign',
    'd2j-asm-verify': 'com.googlecode.dex2jar.tools.AsmVerify',
    'd2j-decrpyt-string': 'com.googlecode.dex2jar.tools.DecryptStringCmd',
    'd2j-dex2jar': 'com.googlecode.dex2jar.tools.Dex2jarCmd',
    'd2j-dex-asmifier': 'com.googlecode.dex2jar.util.ASMifierFileV',
    'd2j-dex-dump': 'com.googlecode.dex2jar.util.Dump',
    'd2j-init-deobf': 'com.googlecode.dex2jar.tools.DeObfInitCmd',
    'd2j-jar2dex': 'com.googlecode.dex2jar.tools.Jar2Dex',
    'd2j-jar2jasmin': 'com.googlecode.dex2jar.tools.Jar2Jasmin',
    'd2j-jar-access': 'com.googlecode.dex2jar.tools.JarAccessCmd',
    'd2j-jar-remap': 'com.googlecode.dex2jar.tools.JarRemap',
    'd2j-jasmin2jar': 'com.googlecode.dex2jar.tools.Jasmin2Jar',
    'dex-dump': 'com.googlecode.dex2jar.util.Dump',
}
JARS = (
    'asm-all-3.3.1.jar',
    'commons-lite-1.15.jar',
    'dex-ir-1.12.jar',
    'dex-reader-1.15.jar',
    'dex-tools-0.0.9.15.jar',
    'dex-translator-0.0.9.15.jar',
    'dx.jar',
    'jar-rename-1.6.jar',
    'jasmin-p2.5.jar',
)
LIBDIR = '/usr/share/dex2jar'

if __name__ == '__main__':
    prg = basename(sys.argv[0])
    if prg == 'dex2jar':
        prg = 'd2j-dex2jar'
    if prg not in CLASS_MAP:
        print('Valid programs: %s' % (', '.join(sorted(CLASS_MAP.keys()),)))
        sys.exit(1)

    clazz = CLASS_MAP[prg]
    classpath = ':'.join([path_join(LIBDIR, x) for x in JARS])

    args = ['java', '-Xms512m', '-Xmx1024m', '-classpath', classpath, clazz]
    args.extend(sys.argv[1:])

    try:
        sp.check_output(args)
    except sp.CalledProcessError:
        sys.exit(1)
