# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Format conversion tools for Vapoursynth"
HOMEPAGE="https://github.com/EleonoreMizo/fmtconv"
SHA="77f26b9a101bf883868a0401f2e89140f4323579"
SRC_URI="https://github.com/EleonoreMizo/fmtconv/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${SHA}/build/unix"

src_prepare () {
	eautoreconf
	default
}

src_install () {
	cd ../.. || die
	einstalldocs
	cd "${S}" || die
	default
	keepdir "/usr/$(get_libdir)/vapoursynth/"
	dosym -r "/usr/$(get_libdir)/libfmtconv.so" "/usr/$(get_libdir)/vapoursynth/libfmtconv.so"
}
