# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

EGIT_COMMIT="5638146d6a68f33710290b329c35802b9230c9c5"
LIBATRAC9_SHA="946e05a9212976626a9f5e52f29c0a7202871f29"
MBEDTLS_PV="3.6.7"

DESCRIPTION="Tool for automatic porting of PlayStation 5 executables to Linux"
HOMEPAGE="https://boykopovar.github.io/AnyPS5/ https://github.com/boykopovar/AnyPS5"
SRC_URI="https://github.com/boykopovar/AnyPS5/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/shadps4-emu/ext-LibAtrac9/archive/${LIBATRAC9_SHA}.tar.gz
		-> ${PN}-LibAtrac9-${LIBATRAC9_SHA}.tar.gz
	https://github.com/Mbed-TLS/mbedtls/releases/download/mbedtls-${MBEDTLS_PV}/mbedtls-${MBEDTLS_PV}.tar.bz2"
S="${WORKDIR}/AnyPS5-${EGIT_COMMIT}"

LICENSE="GPL-2 MIT || ( Apache-2.0 GPL-2+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-arch/zarchive
	dev-libs/libusb:1
	dev-util/glslang
	media-libs/freetype
	media-libs/libjpeg-turbo:=
	media-libs/libsdl2[joystick,sound,video,vulkan]
	media-libs/vulkan-loader
	media-video/ffmpeg:=
	virtual/zlib:="
DEPEND="${RDEPEND}
	dev-libs/stb
	dev-util/spirv-headers
	>=dev-util/vulkan-headers-1.4.310"
BDEPEND="dev-util/glslang
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" )

src_prepare() {
	# mbedtls stays bundled: libSceSsl installs its own allocator through
	# mbedtls_platform_set_calloc_free(), which needs MBEDTLS_PLATFORM_MEMORY, and
	# net-libs/mbedtls does not enable it.
	rmdir 3rdparty/{LibAtrac9,mbedtls} || die
	mv "${WORKDIR}/ext-LibAtrac9-${LIBATRAC9_SHA}" 3rdparty/LibAtrac9 || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_PV}" 3rdparty/mbedtls || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# The bundled mbedtls builds its p256-m helper with BUILD_SHARED_LIBS, which
		# the cmake eclass turns on by default.
		-DBUILD_SHARED_LIBS=OFF
		-DANYPS5_USE_SYSTEM_DEPS=ON
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	# The PS5 system libraries are EXCLUDE_FROM_ALL upstream.
	cmake_build libs
}

src_install() {
	newbin "${BUILD_DIR}/core/relinker/relinker" "${PN}-relinker"
	insinto "/usr/$(get_libdir)/${PN}"
	doins "${BUILD_DIR}"/core/libs/libs/*.prx
	einstalldocs
	dodoc -r docs/user
}

pkg_postinst() {
	elog "The PS5 system libraries are installed in ${EROOT}/usr/$(get_libdir)/${PN}."
	elog "Pass --rpath ${EROOT}/usr/$(get_libdir)/${PN} to ${PN}-relinker, or copy them into"
	elog "libs/ next to the converted executable."
}
