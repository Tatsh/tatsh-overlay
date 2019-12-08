# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils toolchain-funcs multilib

DESCRIPTION="complete cross development package for 65(C)02 systems"
HOMEPAGE="https://cc65.github.io/cc65/"
MY_PV="${PV/_*}"
SRC_URI="https://github.com/cc65/${PN}/archive/V${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="doc? ( app-text/linuxdoc-tools )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	emake
	use doc && emake -C doc
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}
