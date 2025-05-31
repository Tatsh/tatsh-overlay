#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
while read -r ebuild; do
    dn=$(dirname "$ebuild")
    cat=$(dirname "$dn")
    pn=$(basename "$dn")
    pushd "$dn" || exit 1
    phases=(clean manifest install)
    ebuild ./*.ebuild clean manifest install && git add . && pkgdev commit
    popd || exit 1
done < <(git status | grep -E 'deleted:.*ebuild$' | awk '{ print $2 }')
