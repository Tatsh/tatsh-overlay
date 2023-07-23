#!/usr/bin/env bash
contains-element() {
    local e match="$1"
    shift
    for e; do [[ $e == "$match" ]] && return 0; done
    return 1
}
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
test_install=(
    games-arcade/outfox
)
while read -r ebuild; do
    dn=$(dirname "$ebuild")
    cat=$(dirname "$dn")
    pn=$(basename "$dn")
    pushd "$dn" || exit 1
    if grep -qE 'EGO_SUM|YARN_PKGS|ryujinx|videoduplicatefinder' ./*.ebuild; then
        popd || exit 1
        continue
    fi
    phases=(clean manifest prepare)
    if contains-element "${cat}/${pn}" "${test_install[@]}"; then
        phases+=(install)
    fi
    ebuild ./*.ebuild "${phases[@]}" && git add . && pkgdev commit
    popd || exit 1
done < <(git status | grep -E 'deleted:.*ebuild$' | awk '{ print $2 }')
