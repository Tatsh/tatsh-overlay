# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A video processing framework with simplicity in mind."
HOMEPAGE="http://www.vapoursynth.com/"
SRC_URI="https://github.com/vapoursynth/${PN}/archive/R${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="guard-pattern +x86-asm +vsscript +vspipe"

# TODO Do not allow x86-asm USE flag if not amd64/x86, correctly
# TODO doc USE flag (requires Sphinx)
# TODO Conditional python module with python-r1, etc
# TODO Install for every Python 3.x implementation
DEPEND=">=media-libs/zimg-2.4
		x86-asm? ( >=dev-lang/yasm-1.3.0 )
		vsscript? ( >=dev-lang/python-3.9 )"
REQUIRED_USE="vspipe? ( vsscript )"
RDEPEND=""

S="${WORKDIR}/${PN}-R${PV}"

src_prepare () {
	eautoreconf
	default
}

src_configure () {
	x86_asm=
	if use amd64 || use x86; then
		x86_asm=$(use_enable x86-asm )
	fi
	econf \
		"$x86_asm" \
		--disable-python-module \
		$(use_enable guard-pattern ) \
		$(use_enable vspipe ) \
		$(use_enable vsscript )
}
