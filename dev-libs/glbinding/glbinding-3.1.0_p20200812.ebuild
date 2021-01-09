# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="A C++ binding for the OpenGL API, generated using the gl.xml specification."
HOMEPAGE="https://glbinding.org"
MY_SHA="55634e35bd8d8bf58cb36f6ed81af0a0f0939973"
SRC_URI="https://github.com/cginternals/glbinding/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples tools"

DEPEND="
	media-libs/mesa
	examples? ( media-libs/glfw media-libs/glew:0 dev-qt/qtcore )
	tools? ( media-libs/glfw )"
RDEPEND=""
BDEPEND="doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=( "${FILESDIR}/no-khr.patch" )

src_prepare() {
	sed -r -e "s/set\(INSTALL_SHARED.*/set(INSTALL_SHARED \"$(get_libdir)\")/g" -i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=yes
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TOOLS=$(usex tools)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
	)
	cmake_src_configure
}
