# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="C++ frame profiler"
HOMEPAGE="https://github.com/wolfpld/tracy"
SRC_URI="https://github.com/wolfpld/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/capstone
	media-libs/glfw
	media-libs/freetype"
RDEPEND="${DEPEND}"
