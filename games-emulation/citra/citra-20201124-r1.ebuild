# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg-utils

DESCRIPTION="A Nintendo 3DS emulator."
HOMEPAGE="https://citra-emu.org/"
MY_SHA="a13a23051140aa29e8e8c40999651020df84b2b1"
INIH_SHA="1e80a47dffbda813604f0913e2ad68c7054c14e4"
LODEPNG_SHA="31d9704fdcca0b68fb9656d4764fa0fb60e460c2"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
NIHSTRO_SHA="fd69de1a1b960ec296cc67d32257b0f9e2d89ac6"
DYNARMIC_SHA="8d1699ba2db216e569e998ea318d5cde47720e97"
SRC_URI="https://github.com/citra-emu/citra/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/benhoyt/inih/archive/${INIH_SHA}.tar.gz -> ${PN}-inih-${INIH_SHA:0:7}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/neobrain/nihstro/archive/${NIHSTRO_SHA}.tar.gz -> ${PN}-nihstro-${NIHSTRO_SHA:0:7}.tar.gz
	https://api.citra-emu.org/gamedb/ -> ${PN}-compatibility_list-${PV}.json
	https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz"

LICENSE="ZLIB BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/zstd
	dev-cpp/catch:0
	dev-libs/boost:0
	dev-libs/crypto++:0/8
	dev-libs/cubeb
	dev-libs/libfmt:0/7
	dev-libs/mp
	dev-libs/teakra
	>=dev-libs/xbyak-5.941
	media-libs/libsdl2
	net-libs/enet:1.3
	media-video/ffmpeg"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-boost-174.patch"
	"${FILESDIR}/${PN}-src-cmake-fixes.patch"
	"${FILESDIR}/${PN}-externals.patch"
	"${FILESDIR}/${PN}-no-check-submodules.patch"
	"${FILESDIR}/${PN}-xbyak.patch"
	"${FILESDIR}/dynarmic-cmake-fixes.patch"
	"${FILESDIR}/dynarmic-include-path-fixes.patch"
	"${FILESDIR}/dynarmic-system-xbyak.patch"
)

S="${WORKDIR}/${PN}-${MY_SHA}"

src_prepare() {
	rmdir "${S}/externals/inih/inih" \
		"${S}/externals/lodepng/lodepng" \
		"${S}/externals/"{nihstro,soundtouch,dynarmic} || die
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	mv "${WORKDIR}/inih-${INIH_SHA}" "${S}/externals/inih/inih" || die
	mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "${S}/externals/lodepng/lodepng" || die
	mv "${WORKDIR}/nihstro-${NIHSTRO_SHA}" "${S}/externals/nihstro" || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mkdir -p "${WORKDIR}/${P}_build/dist/compatibility_list" || die
	cp "${DISTDIR}/${PN}-compatibility_list-${PV}.json" "${WORKDIR}/${P}_build/dist/compatibility_list/compatibility_list.json" || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_FFMPEG_AUDIO_DECODER=ON
		-DENABLE_FFMPEG_VIDEO_DUMPER=ON
		-DENABLE_WEB_SERVICE=OFF
		-DUSE_SYSTEM_BOOST=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
