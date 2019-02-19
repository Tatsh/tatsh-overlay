# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils git-r3

DESCRIPTION="Researching Wii U emulation."
HOMEPAGE="https://github.com/decaf-emu/decaf-emu"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="GPL-3 BitstreamVera OFL-1.1"
SLOT="0"
IUSE="devtools ffmpeg +opengl qt5 +sdl +vulkan +X"

DEPEND="net-misc/curl
	dev-libs/openssl
	sdl? ( media-libs/libsdl2 )
	sys-libs/zlib
	ffmpeg? ( media-video/ffmpeg )
	vulkan? (
		>=dev-util/glslang-7.10.2984
		>=media-libs/vulkan-loader-1.1.92.1 )
	qt5? (
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5 )
	opengl? ( virtual/opengl )
	X? ( media-gfx/icoutils )
	dev-libs/libfmt
	dev-libs/glbinding
	dev-libs/pugixml"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"

# It will not build without Vulkan enabled
REQUIRED_USE="qt5? ( sdl )
	devtools? ( sdl )
	vulkan"

PATCHES=(
	"${FILESDIR}/system-libs.patch"
)

decaf-use() {
	local flag="$1"
	local out="${1^^}"
	[ -n "$2" ] && out="${2^^}"
	state='OFF'
	use "$flag" && state='ON'
	echo "-DDECAF_${out}=${state}"
}

src_prepare() {
	rm -fR libraries/{fmt,glbinding,glslang,ovsocket,pugixml}
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(decaf-use qt5 qt)
		$(decaf-use opengl gl)
		$(decaf-use sdl)
		$(decaf-use ffmpeg)
		$(decaf-use vulkan)
		$(decaf-use devtools build_tools)
		-DDECAF_INSTALL_DOCSDIR_OVERRIDE=/usr/share/doc/${P}
	)
	cmake-utils_src_configure
}
