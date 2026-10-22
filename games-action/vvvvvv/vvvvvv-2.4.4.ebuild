# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

# Only Make and Play builds may ship the game's assets. Upstream has not
# changed this file since 2022-11-17.
MY_DATA="${PN}-makeandplay-data-20221117.zip"

DESCRIPTION="Retro platformer where you flip gravity instead of jumping"
HOMEPAGE="https://thelettervsixtim.es/ https://github.com/TerryCavanagh/VVVVVV"
# The tag tarball lacks the third_party submodules; the release zip has them.
SRC_URI="https://github.com/TerryCavanagh/VVVVVV/releases/download/${PV}/VVVVVV-${PV}.zip
	makeandplay? ( https://thelettervsixtim.es/makeandplay/data.zip -> ${MY_DATA} )"
S="${WORKDIR}/VVVVVV/desktop_version"

LICENSE="VVVVVV Apache-2.0 BSD ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="makeandplay"
RESTRICT="bindist"

RDEPEND="
	app-emulation/faudio
	dev-games/physfs[zip]
	dev-libs/tinyxml2:=
	media-libs/libsdl2[joystick,sound,video]
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

src_unpack() {
	unpack "VVVVVV-${PV}.zip"
}

src_prepare() {
	# The interim version block asks git for the commit, date and branch, and
	# without a checkout it shows placeholders on the title screen.
	sed -i -e 's/VERSION 2\.8\.12\.\.\.3\.5/VERSION 3.10/' \
		-e 's/^if(NOT OFFICIAL_BUILD)$/if(FALSE)/' \
		-e '/-Werror=implicit-fallthrough/d' \
		-e '/set(CMAKE_INSTALL_RPATH /d' CMakeLists.txt || die
	rm -r VVVVVV-android || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUNDLE_DEPENDENCIES=OFF
		-DMAKEANDPLAY="$(usex makeandplay)"
	)
	cmake_src_configure
}

src_install() {
	exeinto "/usr/libexec/${PN}"
	doexe "${BUILD_DIR}/VVVVVV"
	newbin "${FILESDIR}/${PN}.sh" "${PN}"

	insinto "/usr/share/${PN}"
	doins -r fonts lang
	use makeandplay && newins "${DISTDIR}/${MY_DATA}" data.zip

	make_desktop_entry "${PN}" VVVVVV
	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst
	if ! use makeandplay; then
		elog "VVVVVV needs data.zip from a purchased copy of the game. Copy it to"
		elog "${EROOT}/usr/share/${PN}/data.zip or ~/.local/share/VVVVVV/data.zip."
		elog "Alternatively, enable USE=makeandplay for the free Make and Play edition."
	fi
}
