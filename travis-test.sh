#!/bin/sh
# Enter the prefix if there is one (Travis CI)
if [ ! -d "prefix" ]; then
  echo "Requires prefix"
  exit 1
fi

dirs=$(find . -maxdepth 1 -type d | tail -n +2 | cut -b 3- | grep -vE '^\.git' | grep -vE 'cross\-' | sort)
mkdir prefix/overlay
for i in "$dirs"; do
  cp -vR "$i" prefix/overlay/
done

pushd "prefix"
./startprefix


for i in $(find overlay -type f -name '*.ebuild'); do
  ebuild "$i" install
  test $? -ne 0 && popd && exit 1
done

popd
