# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )
inherit cmake desktop python-single-r1

DESCRIPTION="A Hex Editor for people that value their eye sight when working at 3 AM."
HOMEPAGE="https://github.com/WerWolv/ImHex"
MY_PN="ImHex"
SRC_URI="https://github.com/WerWolv/${MY_PN}/archive/v1.7.0.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="sys-apps/file
	dev-libs/capstone
	media-libs/freetype
	media-libs/glfw
	net-libs/mbedtls"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}"
BDEPEND="sys-devel/llvm
	dev-cpp/nlohmann_json
	media-libs/glm
	${PYTHON_DEPS}"

PATCHES=(
	"${FILESDIR}/${PN}-installation.patch"
	"${FILESDIR}/${PN}-system-libs.patch"
)

S="${WORKDIR}/${MY_PN}-${PV}"

RESTRICT="strip splitdebug"

src_prepare() {
	sed -e "s/find_package(Python /find_package(Python ${EPYTHON:6} EXACT /" \
		-i cmake/build_helpers.cmake || die 'Failed to patch'
	sed -e "s/addVersionDefines()/add_compile_definitions(IMHEX_VERSION=\"${PV}\")/" \
		-i CMakeLists.txt || die 'Failed to patch'
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_SKIP_RPATH=ON
		-DUSE_SYSTEM_LLVM=ON
		-DUSE_SYSTEM_NLOHMANN_JSON=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	fperms 755 /usr/share/${MY_PN}/plugins/{builtin,example}.hexplug
	make_desktop_entry imhex ImHex search Development
	einstalldocs
}
