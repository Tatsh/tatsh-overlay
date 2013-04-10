#!/bin/sh
BOOTSTRAP="bootstrap-prefix.sh"

rm -fvR "$BOOTSTRAP" "$PWD/prefix"
mkdir -p "$PWD/prefix/tmp"
wget -O "$BOOTSTRAP" "http://overlays.gentoo.org/proj/alt/browser/trunk/prefix-overlay/scripts/bootstrap-prefix.sh?format=txt"
bash "$BOOTSTRAP" "$PWD/prefix/tmp" stage1 && \
  bash "$BOOTSTRAP" "$PWD/prefix" stage2 && \
  export PATH="$PWD/prefix/usr/bin:$PATH" && \
  bash "$BOOTSTRAP" "$PWD/prefix" stage3
