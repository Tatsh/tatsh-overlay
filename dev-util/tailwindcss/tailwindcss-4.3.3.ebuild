# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

# Since 4.0 the CLI is no longer part of the tailwindcss package; it ships
# separately as @tailwindcss/cli, which is what files/${PN}-package.json pulls
# in.
NPM_PN="@${PN}/cli"

DESCRIPTION="Utility-first CSS framework, as a standalone CLI."
HOMEPAGE="https://tailwindcss.com https://github.com/tailwindlabs/tailwindcss"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"

# MIT is tailwindcss' own; the rest come from the vendored dependencies.
LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
# Lightning CSS, @parcel/watcher and @tailwindcss/oxide ship prebuilt .node
# binaries.
RESTRICT="strip"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install

	local modules
	modules="/usr/$(get_libdir)/node_modules/${PN}/node_modules"

	# The CLI resolves `@import "tailwindcss"` with node resolution starting from
	# the input CSS file's directory, so a bare symlink only works for CSS that
	# lives inside the install tree. Point NODE_PATH at the vendored copy so it
	# resolves from any project directory.
	cat > "${T}/${PN}" <<-EOF || die
		#!/bin/sh
		NODE_PATH="${modules}\${NODE_PATH:+:\${NODE_PATH}}"
		export NODE_PATH
		exec node "${modules}/${NPM_PN}/dist/index.mjs" "\$@"
	EOF
	dobin "${T}/${PN}"
}
