#!/usr/bin/env bash
cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
test_install=(
    games-arcade/outfox
    games-emulation/ryujinx
)
while read -r ebuild; do
    dn=$(dirname "$ebuild")
    cat=$(dirname "$dn")
    pn=$(basename "$dn")
    pushd "$dn" || exit 1
    old_ifs="$IFS"
    phases=( clean manifest prepare )
    if [[ " ${test_install[*]} " =~ " ${cat}/${pn} " ]]; then
        phases+=( install )
    fi
    ebuild ./*.ebuild "${phases[@]}" && git add . && pkgdev commit
    popd || exit 1
done < <(git status | grep -E 'deleted:.*ebuild$' | awk '{ print $2 }')

