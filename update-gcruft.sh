#!/bin/sh
git rm -f -r app-portage/gcruft
mkdir -p app-portage
pushd app-portage
svn co https://svn.keksbude.net/repos/keks-overlay/app-portage/gcruft/
find -iname '.svn' -exec rm -fvR {} \;
popd

git add app-portage/gcruft
git commit -m "Updated gcruft (via script)"
