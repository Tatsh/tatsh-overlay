#!/usr/bin/env bash

shopt -s extglob

for i in httpext \
         langutil \
         osextension \
         webappmanager \
        ; do
    gpypi create -l tatsh-overlay --metadata-disable "$i" || break
done

new_ebuilds=$(git status | grep -P "^#\t" | grep -v 'modified:' | grep -E '\.ebuild$' | awk '{ print $2 }')

IFS=$'\n'; for i in $new_ebuilds; do
    echo 'PYTHON_DEPEND="2::2.6"' >> "$i"
    echo 'RESTRICT_PYTHON_ABIS="3.*"' >> "$i"
    ebuild "$i" manifest
done
