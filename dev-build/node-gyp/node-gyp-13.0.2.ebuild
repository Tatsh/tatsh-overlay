# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0..5} )

inherit nodejs-mod python-r1

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="Apache-2.0 BSD-2 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="net-libs/nodejs:= ${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_install() {
	nodejs-mod_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/${PN}/bin/${PN}.js"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${PN}/bin/${PN}.js" "/usr/bin/${PN}"
}
