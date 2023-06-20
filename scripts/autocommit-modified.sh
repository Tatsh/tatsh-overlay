#!/usr/bin/env bash
contains-element() {
    local e match="$1"
    shift
    for e; do [[ $e == "$match" ]] && return 0; done
    return 1
}
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
export EDITOR=false
while read -r ebuild; do
    dn=$(dirname "$ebuild")
    cat=$(dirname "$dn")
    pn=$(basename "$dn")
    pushd "$dn" || exit 1
    if grep -qE 'soundfile' ./*.ebuild; then
        popd || exit 1
        continue
    fi
    ebuild ./*.ebuild clean manifest prepare || exit 1
		git add .
		pkgdev commit || pkgdev commit -m "${cat}/${pn}: lint" || exit 1
    popd || exit 1
done < <(git status | grep -E 'modified:.*ebuild$' | awk '{ print $2 }')
