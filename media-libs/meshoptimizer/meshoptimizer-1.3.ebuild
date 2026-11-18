# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Mesh optimization library that makes meshes smaller and faster to render"
HOMEPAGE="https://meshoptimizer.org/ https://github.com/zeux/meshoptimizer"
SRC_URI="https://github.com/zeux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	local mycmakeargs=(
		-DMESHOPT_BUILD_SHARED_LIBS=ON
		-DMESHOPT_WERROR=OFF
	)
	cmake_src_configure
}
