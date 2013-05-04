# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Original Author: tatsh
# Purpose: Node.js npm -g handler

DEPEND=">=net-libs/nodejs-0.8.21
	>=app-misc/jq-1.1
	>=net-misc/wget-1.12-r3"

EXPORT_FUNCTIONS pkg_setup src_install

# @ECLASS-VARIABLE: ENPM_NAME
# @DESCRIPTION: Package name without version, tag, etc.

# TODO
# - Make this cache the file properly
# - How to set SRC_URI dynamically?
# - Find all dependencies and append (if possible) to the $DEPEND variable
npm_pkg_setup() {
	local name="${ENPM_NAME}@${PV}"
	local json=$(node -e "console.log(JSON.stringify(($(npm info "$name"))))")

	echo "$json" | jq .versions | grep "$PV" || die "Version $PV not found"

	if [ -z "$SRC_URI" ]; then
		tarball=$(echo "$json" | jq .dist.tarball | cut -b 2- | sed -e 's/\"$//')

		[ -n "$tarball" ] || die "Tarball URI not found: '$json'"

		wget --unlink "$tarball" -P "${DISTDIR}"
		tarball="$DISTDIR/$(echo "$tarball" | sed -e 's/.*\///')"
		mkdir -p "${S}"
	fi
}

# This method is not very good because it pulls in all the dependencies and
#   does not account for ones that are already installed globally on the system
# NOTE Very likely to have file collisions
npm_src_install() {
	mkdir ${D}/usr
	npm config set prefix "${D}/usr"
	npm install -g "$tarball"
}

# kate: replace-tabs false;
