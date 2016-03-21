#!/bin/bash
git rm -f -r app-portage/gcruft
rm -fR app-portage/gcruft
mkdir -p app-portage/gcruft
pushd app-portage
svn co https://svn.keksbude.net/repos/keks-overlay/app-portage/gcruft/
find -iname '.svn' -exec rm -fvR {} \;
popd

for i in app-portage/gcruft/*.ebuild; do
    patch -p1 "$i" update-gcruft-config-protect.patch
    ebuild "$i" manifest
done

git add app-portage/gcruft
git commit -m "Updated gcruft (via script)"
