#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.."
test_install=(
    games-arcade/outfox
)
while read -r ebuild; do
    dn=$(dirname "$ebuild")
    cat=$(dirname "$dn")
    pn=$(basename "$dn")
    pushd "$dn" || exit 1
    if grep -qE 'EGO_SUM|registry.yarnpkg.com|ryujinx' ./*.ebuild; then
        popd || exit 1
        continue
    fi
    old_ifs="$IFS"
    phases=(clean manifest prepare)
    if [[ " ${test_install[*]} " =~ " ${cat}/${pn} " ]]; then
        phases+=(install)
    fi
    ebuild ./*.ebuild "${phases[@]}" && git add . && pkgdev commit
    popd || exit 1
done < <(git status | grep -E 'deleted:.*ebuild$' | awk '{ print $2 }')
