# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit autotools distutils-r1

DESCRIPTION="A video processing framework with simplicity in mind."
HOMEPAGE="http://www.vapoursynth.com/ https://github.com/vapoursynth/vapoursynth"
MY_PV="R${PV//_/-}"
MY_PV="${MY_PV^^}"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="guard-pattern +x86-asm +vsscript +vspipe"

DEPEND=">=media-libs/zimg-3.0.5
	x86-asm? ( >=dev-lang/yasm-1.3.0 )
	vsscript? ( >=dev-lang/python-3.9 )
	sys-libs/zlib"
REQUIRED_USE="vspipe? ( vsscript )"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare () {
	eautoreconf
	distutils-r1_src_prepare
	default
}

src_configure () {
	x86_asm=
	if use amd64 || use x86; then
		x86_asm=$(use_enable x86-asm)
	fi
	econf \
		"$x86_asm" \
		--disable-python-module \
		"$(use_enable guard-pattern)" \
		"$(use_enable vspipe)" \
		"$(use_enable vsscript)"
	distutils-r1_src_configure
}

src_compile() {
	default
	distutils-r1_src_compile
}

src_install() {
	default
	distutils-r1_src_install
	rm -f "${ED}/usr/$(get_libdir)/libvapoursynth"*.la
}
