# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic linux-info

EGIT_COMMIT="f6232fcfda70644495273f6b8dd88cf0603463d6"
JXRLIB_SHA="f7521879862b9085318e814c6157490dd9dbbdb4"
VGMSTREAM_SHA="7c520e8f9b078dfde2f84f1b5bcbad0c6c415806"
LIBFVAD_SHA="532ab666c20d3cfda38bca63abbb0f152706c369"
LIBATRAC9_SHA="946e05a9212976626a9f5e52f29c0a7202871f29"
MBEDTLS_PV="3.6.7"
# The LibreSSL tests generate their error strings from this tree.
LIBRESSL_OPENBSD_SHA="078b3d1df8ca2011c1605cd40418c58fa0f5b143"

DESCRIPTION="Tool for automatic porting of PlayStation 5 executables to Linux"
HOMEPAGE="https://boykopovar.github.io/AnyPS5/ https://github.com/boykopovar/AnyPS5"
SRC_URI="https://github.com/boykopovar/AnyPS5/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/shadps4-emu/ext-LibAtrac9/archive/${LIBATRAC9_SHA}.tar.gz
		-> ${PN}-LibAtrac9-${LIBATRAC9_SHA}.tar.gz
	https://github.com/dpirch/libfvad/archive/${LIBFVAD_SHA}.tar.gz -> ${PN}-libfvad-${LIBFVAD_SHA}.tar.gz
	https://github.com/4creators/jxrlib/archive/${JXRLIB_SHA}.tar.gz -> ${PN}-jxrlib-${JXRLIB_SHA}.tar.gz
	https://github.com/vgmstream/vgmstream/archive/${VGMSTREAM_SHA}.tar.gz -> ${PN}-vgmstream-${VGMSTREAM_SHA}.tar.gz
	https://github.com/Mbed-TLS/mbedtls/releases/download/mbedtls-${MBEDTLS_PV}/mbedtls-${MBEDTLS_PV}.tar.bz2
	test? (
		https://github.com/libressl/openbsd/archive/${LIBRESSL_OPENBSD_SHA}.tar.gz
			-> ${PN}-libressl-openbsd-${LIBRESSL_OPENBSD_SHA:0:7}.tar.gz
	)"
S="${WORKDIR}/AnyPS5-${EGIT_COMMIT}"

LICENSE="BSD BSD-2 GPL-2 ISC MIT || ( Apache-2.0 GPL-2+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/zarchive
	app-arch/zstd:=
	dev-libs/libusb:1
	>=dev-libs/quickjs-ng-0.17.0:=
	dev-util/glslang
	media-libs/freetype
	media-libs/libjpeg-turbo:=
	media-libs/libogg
	media-libs/libsdl2[joystick,sound,video,vulkan]
	media-libs/libvorbis
	media-libs/opus
	media-libs/vulkan-loader
	net-libs/nghttp2
	media-video/ffmpeg:=
	virtual/zlib:="
DEPEND="${RDEPEND}
	dev-libs/stb
	dev-util/spirv-headers
	>=dev-util/vulkan-headers-1.4.310"
BDEPEND="dev-util/glslang
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-system-libs.patch"
	# RequireNoResidentDepthRead read every surface's HTILE range before checking
	# the surface had one; single-sample and refused surfaces have none.
	"${FILESDIR}/${PN}-depth-read-oob.patch"
)

# Guest write watching; without it the emulator falls back to comparing guest
# memory, and the agc_driver tests that need watched memory fail.
CONFIG_CHECK="~USERFAULTFD"
WARNING_USERFAULTFD="CONFIG_USERFAULTFD is needed for guest memory write watching."

src_prepare() {
	# mbedtls stays bundled: libSceSsl installs its own allocator through
	# mbedtls_platform_set_calloc_free(), which needs MBEDTLS_PLATFORM_MEMORY, and
	# net-libs/mbedtls does not enable it.
	rmdir 3rdparty/{LibAtrac9,jxrlib,libfvad,mbedtls,vgmstream} || die
	# These wrappers use private codec headers and data structures.
	mv "${WORKDIR}/jxrlib-${JXRLIB_SHA}" 3rdparty/jxrlib || die
	mv "${WORKDIR}/vgmstream-${VGMSTREAM_SHA}" 3rdparty/vgmstream || die
	# libwebrtc uses libfvad internal headers and structures.
	mv "${WORKDIR}/libfvad-${LIBFVAD_SHA}" 3rdparty/libfvad || die
	mv "${WORKDIR}/ext-LibAtrac9-${LIBATRAC9_SHA}" 3rdparty/LibAtrac9 || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_PV}" 3rdparty/mbedtls || die
	if use test; then
		rmdir 3rdparty/libressl-openbsd || die
		mv "${WORKDIR}/openbsd-${LIBRESSL_OPENBSD_SHA}" 3rdparty/libressl-openbsd || die
	fi
	cmake_src_prepare
	if use test; then
		# The Vorbis tests build the bundled encoder; use the system one.
		sed -e '/add_library(vorbisenc STATIC/,/set_target_properties(vorbisenc/c\
			pkg_check_modules(VORBISENC REQUIRED IMPORTED_TARGET vorbisenc)\
			add_library(vorbisenc INTERFACE)\
			target_link_libraries(vorbisenc INTERFACE PkgConfig::VORBISENC vorbis)' \
			-i core/libs/prx/libSceVorbisDec/CMakeLists.txt || die
		# Jsc.hpp includes <quickjs.h> once the system-libs patch drops the
		# bundled path, and these tests get no include path for it.
		# shellcheck disable=SC2016
		sed -e 's|target_link_libraries(nkwebkit_${testName}_tests PRIVATE libSceNKWebKit libSceJsc libc)|& \
			target_link_libraries(nkwebkit_${testName}_tests PRIVATE qjs)|' \
			-i core/libs/prx/libSceNKWebKit/CMakeLists.txt || die
		# The pad tests add the bundled SDL2's include directory, which the
		# tarball does not have; point them at the system SDL2's.
		# shellcheck disable=SC2016
		sed -e 's|${CMAKE_SOURCE_DIR}/3rdparty/SDL2/include|${ANYPS5_SDL2_INCLUDE_DIR}|' \
			-i core/libs/prx/libSceVideoOut/CMakeLists.txt || die
		# Several tests call SDL directly and rely on the bundled static SDL2
		# coming in through the library under test. With the shared system SDL2
		# that fails ("DSO missing from command line"), so link SDL into every
		# test executable; --as-needed drops it where unused.
		# shellcheck disable=SC2016
		sed -e '/^function(add_test_executable target)$/,/^endfunction()$/s|^    add_executable(${target} ${ARGN})$|&\n    target_link_libraries(${target} PRIVATE SDL2-static)|' \
			-i CMakeLists.txt || die
	fi
}

src_configure() {
	if use test; then
		# libc defines LibcCaptureRegisters/LibcRestoreRegisters in top-level asm
		# (RegisterContext.cpp, pulled in through Exports.cpp). LTO bitcode has
		# no symbol for those, so the test executables that link libc's objects
		# fail with undefined references to them. Upstream CI builds without LTO.
		filter-lto
	fi
	local mycmakeargs=(
		# The bundled mbedtls builds its p256-m helper with BUILD_SHARED_LIBS, which
		# the cmake eclass turns on by default.
		-DBUILD_SHARED_LIBS=OFF
		-DANYPS5_USE_SYSTEM_DEPS=ON
		"-DBUILD_TESTING=$(usex test)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	# The PS5 system libraries are EXCLUDE_FROM_ALL upstream.
	cmake_build libs
}

src_test() {
	# The agc_driver tests run on the GPU through Vulkan.
	local dev
	for dev in /dev/dri /dev/nvidia*; do
		[[ -e ${dev} ]] && addwrite "${dev}"
	done
	addpredict /dev/char
	addwrite /proc/self/task
	local exclude=(
		# Need a git checkout; the release tarball is not one.
		conventions_git_errors
		test_script_registration
		web_library_assets
		# Compares a child's terminal output, which differs without a TTY.
		log_file
		# Compares NGS2 filter output bit for bit against a model, which fails
		# with this build's flags.
		ngs2_filter
		# Needs multicast networking, which the network sandbox blocks.
		guest_socket_options_multicast
		# Pass when run directly but fail under the Portage sandbox (file
		# ownership checks and relaunching the guest process).
		pad_input
		loadexec_arguments
		exec_arguments
	)
	local IFS='|'
	local myctestargs=( --output-on-failure -E "^(${exclude[*]})\$" )
	unset IFS
	cmake_src_test
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
