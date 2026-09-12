# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Decode and encode EA Layer 3 audio as used by Need for Speed World."
HOMEPAGE="https://github.com/driftyz700/ealayer3-nfsw"
SRC_URI="https://github.com/driftyz700/${PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boost:=
	media-sound/mpg123-base
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare

	# CMake 4 refuses a minimum below 3.5.
	sed -i -e 's/cmake_minimum_required (VERSION 2.8)/cmake_minimum_required (VERSION 3.10)/' \
		CMakeLists.txt || die
}

src_install() {
	cmake_src_install
	einstalldocs
}
