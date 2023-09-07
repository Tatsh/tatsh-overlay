#!/bin/bash
if [[ $UID == 0 ]]; then
	echo 'Do not run as root' >&2
	exit 1
fi
where=$(pwd -P)
cd "${HOME}/dev/overlay/gentoo" || exit 1
gh pr checkout --force 32109
while read -r action _ mode filename; do
	if [[ "${action}" == create ]]; then
		dn=$(dirname "$filename")
		mkdir -p "${where}/${dn}"
		cp "${filename}" "${where}/${dn}"
		if [[ "${filename}" == *.ebuild ]]; then
			ebuild "${filename}" manifest
		fi
	elif [[ "${action}" == delete ]]; then
		rm -f "${where}/${filename}"
	fi
done < <(git diff --summary "HEAD~$(gh api /repos/gentoo/gentoo/pulls/32109 | jq -S .commits)")
