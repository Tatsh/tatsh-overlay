# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod systemd

# The Node application lives in the server subdirectory of the upstream tree,
# and the node_modules archive is unpacked alongside it.
NODEJS_MOD_PREFIX="server"

DESCRIPTION="Server endpoints to process or create content for chatting."
HOMEPAGE="https://anythingllm.com/"
SRC_URI="https://github.com/Mintplex-Labs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="0BSD Apache-2.0 BSD BSD-2 CC0-1.0 ISC MIT PSF-2 Unlicense WTFPL-2"
SLOT="0"
# This package is not usable yet. Left unkeyworded on purpose so that nobody
# tries to install it.
# KEYWORDS="~amd64"
RESTRICT="strip"

DEPEND="dev-db/prisma-engines
	dev-libs/glib
	media-libs/vips
	>=sci-libs/onnxruntime-1.23.2"
RDEPEND="net-libs/nodejs:="

src_compile() {
	nodejs-mod_src_compile

	# Prebuilt binaries for other platforms.
	rm -fR "${NODEJS_MOD_PREFIX}"/node_modules/bare-{fs,os}/prebuilds \
		"${NODEJS_MOD_PREFIX}"/node_modules/tar-fs/node_modules/bare-{fs,os}/prebuilds || die
}

src_install() {
	nodejs-mod_src_install
	systemd_newunit "${FILESDIR}/${PN}.service" "${PN}@.service"
}
