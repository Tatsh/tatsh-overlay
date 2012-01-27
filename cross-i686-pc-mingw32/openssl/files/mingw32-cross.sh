#!/bin/sh
# 
# Based on mingw32.bat
#
# Copyright (c) 2012 Andrew Udvare [au]
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

perl Configure mingw $@

function noasm {
  echo Generating makefile

  perl util/mkfiles.pl > MINFO
  perl util/mk1mf.pl gaswin Mingw32 > ms/mingw32a.mak

  echo 'Generating DLL definition files'

  perl util/mkdef.pl 32 libeay > ms/libeay32.def
  if [ $? -eq 1 ]; then exit 1; fi
  perl util/mkdef.pl 32 ssleay > ms/ssleay32.def
  if [ $? -eq 1 ]; then exit 1; fi

  # cp ms/tlhelp32.h outinc

  echo 'Building the libraries'
  make -f ms/mingw32a.mak
  if [ $? -eq 1 ]; then exit 1; fi

  echo 'Generating the DLLs and input libraries'
  i686-pc-mingw32-dllwrap --dllname libeay32.dll --output-lib out/libeay32.a --def ms/libeay32.def out/libcrypto.a -lwsock32 -lgdi32
  if [ $? -eq 1 ]; then exit 1; fi
  i686-pc-mingw32-dllwrap --dllname libssl32.dll --output-lib out/libssl32.a --def ms/ssleay32.def out/libssl.a out/libeay32.a
  if [ $? -eq 1 ]; then exit 1; fi

  echo 'Done compiling OpenSSL'
}

perl -e "exit 1 if '%1' eq 'no-asm'"
if [ $? -eq 1 ]; then noasm; fi

echo 'Generating x86 for GNU assember'

pwd -P

echo Bignum
cd crypto/bn/asm
perl bn-586.pl gaswin > bn-win32.s
perl co-586.pl gaswin > co-win32.s
cd ../../..

echo DES
cd crypto/des/asm
perl des-586.pl gaswin > d-win32.s
cd ../../..

echo crypt
cd crypto/des/asm
perl crypt586.pl gaswin > y-win32.s
cd ../../..

echo Blowfish
cd crypto/bf/asm
perl bf-586.pl gaswin > b-win32.s
cd ../../..

echo CAST5
cd crypto/cast/asm
perl cast-586.pl gaswin > c-win32.s
cd ../../..

echo RC4
cd crypto/rc4/asm
perl rc4-586.pl gaswin > r4-win32.s
cd ../../..

echo MD5
cd crypto/md5/asm
perl md5-586.pl gaswin > m5-win32.s
cd ../../..

echo SHA1
cd crypto/sha/asm
perl sha1-586.pl gaswin > s1-win32.s
cd ../../..

echo RIPEMD160
cd crypto/ripemd/asm
perl rmd-586.pl gaswin > rm-win32.s
cd ../../..

echo RC5/32
cd crypto/rc5/asm
perl rc5-586.pl gaswin > r5-win32.s
cd ../../..
echo CPUID
cd crypto
perl x86cpuid.pl gaswin > cpu-win32.s
cd ..

noasm
