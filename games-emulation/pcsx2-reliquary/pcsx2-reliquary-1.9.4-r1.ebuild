# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop fcaps flag-o-matic optfeature toolchain-funcs xdg

MY_PN="pcsx2-reliquary"
MY_TAG="v${PV}-reliquary"

DESCRIPTION="PCSX2 fork with speedrun and practice tooling."
HOMEPAGE="https://github.com/DiscoStarslayer/pcsx2-reliquary"
SRC_URI="https://github.com/DiscoStarslayer/${MY_PN}/archive/refs/tags/${MY_TAG}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}-reliquary"

# Same set as the PCSX2 it forks: upstream's own GPL-3+ plus the licences of
# everything under 3rdparty/.
LICENSE="
	GPL-3+ Apache-2.0 BSD BSD-2 BSD-4 Boost-1.0 CC0-1.0 GPL-2+
	ISC LGPL-2.1+ LGPL-3+ MIT OFL-1.1 ZLIB public-domain
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa cpu_flags_x86_sse4_1 +clang jack pulseaudio sndio wayland"
REQUIRED_USE="amd64? ( cpu_flags_x86_sse4_1 )"

COMMON_DEPEND="
	app-arch/lz4:=
	app-arch/zstd:=
	>=dev-cpp/rapidyaml-0.10:=
	dev-qt/qtbase:6=[X,concurrent,gui,widgets]
	dev-qt/qtsvg:6
	>=gui-libs/kddockwidgets-2.3:=
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd[X]
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	media-libs/libsdl3
	media-libs/libwebp:=
	media-libs/plutosvg
	media-libs/plutovg
	media-libs/shaderc
	media-libs/vulkan-loader
	media-video/ffmpeg:=
	net-libs/libpcap
	net-misc/curl
	sys-apps/dbus
	virtual/libudev:=
	virtual/zlib:=
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXrandr
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	pulseaudio? ( media-libs/libpulse )
	sndio? ( media-sound/sndio:= )
	wayland? ( dev-libs/wayland )
"
RDEPEND="
	${COMMON_DEPEND}
	>=games-emulation/pcsx2_patches-0_p20241020
"
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	dev-qt/qttools:6[linguist]
	clang? ( llvm-core/clang:* )
	wayland? (
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
		kde-frameworks/extra-cmake-modules
	)
"

# Carried over from games-emulation/pcsx2, which this tracks closely. Its
# ffmpeg9 patch is not among them: this fork already carries the upstream fix
# that replaced AVCodec::pix_fmts with avcodec_get_supported_config().
PATCHES=(
	"${FILESDIR}/${PN}-1.7.5232-cubeb-automagic.patch"
	"${FILESDIR}/${PN}-1.7.5835-musl-header.patch"
	"${FILESDIR}/${PN}-2.5.317-flags.patch"
	"${FILESDIR}/${PN}-2.6.3-climits.patch"
	"${FILESDIR}/${PN}-2.6.3-cubeb-alsa.patch"
	"${FILESDIR}/${PN}-2.8.0-musl-sysconf.patch"
	"${FILESDIR}/${PN}-2.8.1-libcxx23.patch"
	"${FILESDIR}/${P}-system-wayland-protocols.patch"
)

CMAKE_QA_COMPAT_SKIP=1

src_prepare() {
	cmake_src_prepare

	# paraLLEl-GS is a submodule, so the archive carries the directory but
	# none of its contents, and the top level CMakeLists.txt decides whether
	# to build it by testing for that directory rather than for its
	# CMakeLists.txt. Everything that uses it is behind if(TARGET
	# parallel-gs), so removing the empty directory drops the renderer
	# cleanly. Vendoring it would mean carrying Granite and its own
	# submodules as well.
	rm -rf pcsx2/GS/parallel-gs || die

	sed -e '/set(PCSX2_GIT_TAG "")/s/""/"'"${MY_TAG}"'"/' \
		-i cmake/Pcsx2Utils.cmake || die

	# Upstream pins versions of these more tightly than it needs to.
	sed -e '/find_package(\(Qt6\|SDL3\)/s/ [0-9.]* / /' \
		-i cmake/SearchForStuff.cmake || die

	# Gentoo ships no .cmake files for plutovg or plutosvg.
	sed -e '/^find_package(plutovg/d' \
		-e '/^find_package(plutosvg/c\
			find_package(PkgConfig REQUIRED)\
			pkg_check_modules(plutovg REQUIRED IMPORTED_TARGET plutovg)\
			alias_library(plutovg::plutovg PkgConfig::plutovg)\
			pkg_check_modules(plutosvg REQUIRED IMPORTED_TARGET plutosvg)\
			alias_library(plutosvg::plutosvg PkgConfig::plutosvg)' \
		-i cmake/SearchForStuff.cmake || die
}

src_configure() {
	# LTO causes runtime issues in PCSX2 proper, bug #980365.
	filter-lto

	if use clang && ! tc-is-clang; then
		local -x CC=${CHOST}-clang CXX=${CHOST}-clang++
		strip-unsupported-flags
	fi

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=no
		# PACKAGE_MODE compiles in the path from the executable to
		# ${CMAKE_INSTALL_DATADIR}/PCSX2, so moving the data directory here
		# keeps every resource clear of games-emulation/pcsx2.
		-DCMAKE_INSTALL_DATADIR="share/${PN}"
		-DDISABLE_ADVANCE_SIMD=yes
		-DENABLE_TESTS=no
		-DPACKAGE_MODE=yes
		-DUSE_BACKTRACE=no
		-DUSE_LINKED_FFMPEG=yes
		-DUSE_VTUNE=no
		-DUSE_VULKAN=yes
		"-DWAYLAND_API=$(usex wayland)"
		-DX11_API=yes

		# Bundled cubeb, see the cubeb-automagic patch.
		"-DCHECK_ALSA=$(usex alsa)"
		"-DCHECK_JACK=$(usex jack)"
		"-DCHECK_PULSE=$(usex pulseaudio)"
		"-DCHECK_SNDIO=$(usex sndio)"
		-DLAZY_LOAD_LIBS=no
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# The executable is named pcsx2-qt like the one it forks. It finds its
	# resources by a path relative to itself, so renaming it in place is safe
	# and lets both be installed at once.
	mv "${ED}/usr/bin/pcsx2-qt" "${ED}/usr/bin/${PN}-qt" || die
	rm -f "${ED}/usr/share/applications"/*.desktop || die

	newicon bin/resources/icons/AppIconLarge.png "${PN}.png"
	make_desktop_entry "${PN}-qt" "PCSX2 Reliquary" "${PN}"

	dodoc README.md
}

pkg_postinst() {
	xdg_pkg_postinst

	fcaps cap_net_admin,cap_net_raw=eip "usr/bin/${PN}-qt"

	elog "The executable is ${PN}-qt, so this can be installed alongside"
	elog "games-emulation/pcsx2. Note that both read their configuration from"
	elog "the same .config/PCSX2 directory in your home directory."

	optfeature "UI sound effects support" \
		media-sound/alsa-utils \
		media-libs/gst-plugins-base:1.0
}
