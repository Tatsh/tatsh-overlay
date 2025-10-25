# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Community fork of QtWebKit."
HOMEPAGE="https://github.com/movableink/webkit"
SHA="1ab4d21d082e89fe1837c0279467a6da18c78cf0"
SRC_URI="https://github.com/movableink/webkit/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"

LICENSE="LGPL-2 BSD-2"
SLOT="6/${PV%%_*}"
KEYWORDS="~amd64"
IUSE="X video"

DEPEND="dev-db/sqlite
	dev-libs/hyphen
	dev-libs/icu:=
	dev-libs/libgcrypt
	dev-libs/libtasn1
	dev-libs/libxml2
	dev-libs/libxslt
	dev-qt/qtbase:6[X?,gui,network,widgets]
	dev-qt/qtpositioning:6
	dev-qt/qtsensors:6
	media-libs/harfbuzz
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libwebp
	media-libs/woff2
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/ruby"

PATCHES=(
	"${FILESDIR}/${PN}-fix-header.patch"
	"${FILESDIR}/${PN}-fix-linking.patch"
	"${FILESDIR}/${PN}-size.patch"
)

S="${WORKDIR}/webkit-${SHA}"

src_configure() {
	# Disable assertions https://bugs.webkit.org/show_bug.cgi?id=284786
	append-cxxflags -U_GLIBCXX_ASSERTIONS
	filter-lto # LTO causes bin/jsc to fail to compile.
	local mycmakeargs=(
		"-DENABLE_X11_TARGET=$(usex X)"
		"-DENABLE_VIDEO=$(usex video)"
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
		-DDEVELOPER_MODE_FATAL_WARNINGS=OFF
		-DENABLE_PRINT_SUPPORT=ON
		-DENABLE_SPELLCHECK=OFF
		-DPORT=Qt
		-DUSE_MINIMAL_DEBUG_INFO=ON
		-DUSE_SYSTEM_MALLOC=ON
		-Wno-dev
	)
	cmake_src_configure
}
