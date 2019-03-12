# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit cmake-utils

DESCRIPTION="Library to parse Apple's binarycookies format. "
HOMEPAGE="https://github.com/Tatsh/bincookie"
SRC_URI="https://github.com/Tatsh/bincookie/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+tools"
DOCS=( README.md )

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '27s/^if(DOXYGEN_FOUND.*/if(WITH_DOCS AND DOXYGEN_FOUND)/' \
		-i CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DWITH_EXAMPLES=$(usex tools)
	)
	cmake-utils_src_configure
}
