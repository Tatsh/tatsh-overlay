# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

LIBCHDR_SHA="8bba7745d758627258b315997a860039244cedaf"

DESCRIPTION="Convert sequenced video game music to standard formats"
HOMEPAGE="https://github.com/vgmtrans/vgmtrans"
SRC_URI="https://github.com/vgmtrans/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rtissera/libchdr/archive/${LIBCHDR_SHA}.tar.gz -> libchdr-${LIBCHDR_SHA}.tar.gz"

# vgmtrans Zlib, bundled libchdr BSD, unarr LGPL-3, mio MIT; the GUI uses the proprietary BASS.
LICENSE="ZLIB BSD LGPL-3 MIT gui? ( bass )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui"
RESTRICT="gui? ( bindist mirror )"

RDEPEND="dev-libs/libfmt:=
	dev-libs/spdlog:=
	virtual/minizip:=
	virtual/zlib:=
	gui? (
		dev-qt/qtbase:6[dbus,gui,widgets]
		dev-qt/qtsvg:6
	)"
DEPEND="${RDEPEND}
	dev-cpp/nlohmann_json"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" )

# Upstream ships BASS and BASSMIDI only as binaries.
QA_PREBUILT="usr/lib*/libbass*.so"

src_prepare() {
	rmdir lib/libchdr || die
	mv "${WORKDIR}/libchdr-${LIBCHDR_SHA}" lib/libchdr || die
	rm -r lib/nlohmann || die
	# The About dialog embeds the licences of bundled copies that are not used here.
	sed -e '/legal\/zlib/d' -e '/legal\/spdlog/d' -i src/ui/qt/resources/resources.qrc || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# The tarball is not a git checkout; fall back to the project version.
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
		-DENABLE_CLI=ON
		-DENABLE_UI_QT="$(usex gui)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Upstream has no install rule for the CLI.
	dobin "${BUILD_DIR}/bin/vgmtrans-cli"
	# The BASS install rules sit in an EXCLUDE_FROM_ALL subdirectory and never run.
	use gui && dolib.so lib/bass/libbass.so lib/bass/libbassmidi.so
}
