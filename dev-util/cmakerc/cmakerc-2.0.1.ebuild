# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="cmrc"
DESCRIPTION="A resource compiler in a single CMake script."
HOMEPAGE="https://github.com/vector-of-bool/cmrc"
SRC_URI="https://github.com/vector-of-bool/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-build/cmake"

src_install() {
	insinto /usr/share/cmake/cmakerc
	newins CMakeRC.cmake cmakerc-config.cmake
}
