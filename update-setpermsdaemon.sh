#!/usr/bin/env bash

if [ $UID != 0 ]; then
    echo 'Must be root'
    exit 1
fi

if [ -d sys-apps/setpermsdaemon ]; then
    pushd sys-apps/setpermsdaemon
        rm *.ebuild
    popd
fi

gpypi create -l tatsh-overlay --metadata-disable -c sys-apps setpermsdaemon

patch=sys-apps/setpermsdaemon/files/gpypi-generated-ebuild.patch
ebuild="$(find sys-apps/setpermsdaemon -maxdepth 1 -iname '*.ebuild' | cut -c 1-)"
atom="${ebuild%.*}"
version="$(qatom "$atom" | awk '{ print $3 }')"
# +++ setpermsdaemon-0.1.1.ebuild
sed -r -e "2s/^(\+\+\+\ssetpermsdaemon\-)([0-9]+\.){2}[0-9]+(\.ebuild.*)/\1${version}\3/" -i "$patch"
patch -d sys-apps/setpermsdaemon -i files/gpypi-generated-ebuild.patch
ebuild "$ebuild" manifest
