# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Format conversion tools for Vapoursynth"
HOMEPAGE="https://github.com/EleonoreMizo/fmtconv"
SRC_URI="https://github.com/EleonoreMizo/${PN}/archive/r${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-r${PV}/build/unix"

src_prepare () {
	eautoreconf
	default
}

src_install () {
	# TODO doc directory HTML
	cd ../..
	dodoc doc/license.txt README.md
	cd build/unix
	default
	keepdir /usr/lib/vapoursynth/
	dosym /usr/lib/libfmtconv.so /usr/lib/vapoursynth/libfmtconv.so
}
