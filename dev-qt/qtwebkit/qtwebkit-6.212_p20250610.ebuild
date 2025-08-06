# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Community fork of QtWebKit."
HOMEPAGE="https://github.com/movableink/webkit"
SHA="88e74762f8e6ffe8046facc88949bf21237f8f31"
SRC_URI="https://github.com/movableink/webkit/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"

LICENSE="LGPL-2 BSD-2"
SLOT="6/${PV%%_*}"
KEYWORDS="~amd64"
IUSE="X"

DEPEND="dev-lang/ruby
	dev-libs/hyphen
	dev-libs/icu:=
	dev-libs/libgcrypt
	dev-libs/libtasn1
	dev-libs/libxml2
	dev-libs/libxslt
	dev-qt/qtbase:6
	dev-qt/qtpositioning:6
	dev-qt/qtsensors:6
	media-libs/harfbuzz
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libwebp
	media-libs/woff2
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-fix-header.patch"
	"${FILESDIR}/${PN}-size.patch"
	"${FILESDIR}/qt-6.9.1.patch"
)

S="${WORKDIR}/webkit-${SHA}"

src_configure() {
	# Disable assertions https://bugs.webkit.org/show_bug.cgi?id=284786
	append-cxxflags -U_GLIBCXX_ASSERTIONS
	filter-lto
	local mycmakeargs=(
		"-DENABLE_X11_TARGET=$(usex X)"
		-DDEVELOPER_MODE_FATAL_WARNINGS=OFF
		#-DENABLE_DEVICE_ORIENTATION=ON
		#-DENABLE_PRINT_SUPPORT=ON
		#-DENABLE_SPELLCHECK=OFF
		-DPORT=Qt
		-DUSE_MINIMAL_DEBUG_INFO=ON
		-DUSE_SYSTEM_MALLOC=ON
		# Broken
		# -DENABLE_ASSERTS=OFF
		# -DENABLE_MEDIA_SOURCE=$(usex gstreamer)
		# -DENABLE_WEB_AUDIO=$(usex gstreamer)
		# -DUSE_GSTREAMER=$(usex gstreamer)
	)
	cmake_src_configure
}
