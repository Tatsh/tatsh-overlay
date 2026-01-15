# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Community fork of QtWebKit."
HOMEPAGE="https://github.com/movableink/webkit"
SHA="1ab4d21d082e89fe1837c0279467a6da18c78cf0"
SRC_URI="https://github.com/movableink/webkit/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"

S="${WORKDIR}/webkit-${SHA}"
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
	virtual/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/ruby:*"

PATCHES=(
	"${FILESDIR}/${PN}-fix-header.patch"
	"${FILESDIR}/${PN}-fix-linking.patch"
	"${FILESDIR}/${PN}-size.patch"
)

src_configure() {
	local base_ver
	# Disable assertions https://bugs.webkit.org/show_bug.cgi?id=284786
	append-cxxflags -U_GLIBCXX_ASSERTIONS
	filter-lto # LTO causes bin/jsc to fail to compile.
	base_ver=$(best_version dev-qt/qtbase:6)
	base_ver="${base_ver:14}"
	if ! [ -d "${EPREFIX}/usr/include/qt6/QtCore/${base_ver}" ]; then
		ewarn 'Falling back to guessing Qt 6 include directory. This may fail.'
		base_ver=$(basename "$(find "${EPREFIX}/usr/include/qt6/QtCore" -maxdepth 1 -type d -name '6*')")
		[ -n "${base_ver}" ] || die
	fi
	local mycmakeargs=(
		"-DENABLE_X11_TARGET=$(usex X)"
		"-DENABLE_VIDEO=$(usex video)"
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
		-DDEVELOPER_MODE_FATAL_WARNINGS=OFF
		-DENABLE_PRINT_SUPPORT=ON
		-DENABLE_SPELLCHECK=OFF
		-DPORT=Qt
		# Detection broken since 6.10.1.
		-DQt6Gui_PRIVATE_INCLUDE_DIRS="${EPREFIX}/usr/include/qt6/QtGui/${base_ver}/QtGui;${EPREFIX}/usr/include/qt6/QtGui/${base_ver};${EPREFIX}/usr/include/qt6/QtCore/${base_ver}"
		-DQt6Network_PRIVATE_INCLUDE_DIRS="${EPREFIX}/usr/include/qt6/QtNetwork/${base_ver}/QtNetwork;${EPREFIX}/usr/include/qt6/QtCore/${base_ver};${EPREFIX}/usr/include/qt6/QtNetwork/${base_ver}"
		-DUSE_MINIMAL_DEBUG_INFO=ON
		-DUSE_SYSTEM_MALLOC=ON
		-Wno-dev
	)
	cmake_src_configure
}
