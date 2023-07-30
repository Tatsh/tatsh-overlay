# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="ncurses,readline"

inherit flag-o-matic pax-utils python-r1 toolchain-funcs xdg-utils

DESCRIPTION="Original Xbox emulator."
HOMEPAGE="https://xemu.app/ https://github.com/xemu-project/xemu"
GENCONFIG_SHA="44bab849ce87fceafd74703bfcf2b61a1a1b738f"
HTTPLIB_SHA="0f1b62c2b3d0898cbab7aa685c2593303ffdc1a2"
IMGUI_SHA="fceff3210b9ecfa8fc66710a00f4cabc2447460f"
IMPLOT_SHA="cc5e1daa5c7f2335a9460ae79c829011dc5cef2d"
KEYCODEMAPDB_SHA="d21009b1c9f94b740ea66be8e48a1d8ad8124023"
NV2A_VSH_CPU_SHA="d5a7308809a80e1b01b5c016127d4f1b91c8673b"
SOFTFLOAT_SHA="b64af41c3276f97f0e181920400ee056b9c88037"
TESTFLOAT_SHA="5a59dcec19327396a011a17fd924aed4fec416b3"
TOMLPLUSPLUS_SHA="c635f218c0aefc801d9748841930365e54fe3089"
SRC_URI="https://github.com/xemu-project/xemu/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/qemu-project/keycodemapdb/-/archive/${KEYCODEMAPDB_SHA}/keycodemapdb-${KEYCODEMAPDB_SHA}.tar.bz2 -> ${PN}-keycodemapdb-${KEYCODEMAPDB_SHA:0:7}.tar.bz2
	https://github.com/abaire/nv2a_vsh_cpu/archive/${NV2A_VSH_CPU_SHA}.tar.gz -> ${PN}-nv2a_vsh_cpu-${NV2A_VSH_CPU_SHA:0:7}.tar.gz
	https://github.com/xemu-project/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> ${PN}-implot-${IMPLOT_SHA:0:7}.tar.gz
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/${SOFTFLOAT_SHA}/berkeley-softfloat-3-${SOFTFLOAT_SHA}.tar.bz2 -> ${PN}-softfloat-${SOFTFLOAT_SHA:0:7}.tar.bz2
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/${TESTFLOAT_SHA}/berkeley-testfloat-3-${TESTFLOAT_SHA}.tar.bz2 -> ${PN}-testfloat-${TESTFLOAT_SHA:0:7}.tar.bz2
	https://github.com/mborgerson/genconfig/archive/${GENCONFIG_SHA}.tar.gz -> ${PN}-genconfig-${GENCONFIG_SHA:0:7}.tar.gz
	https://github.com/marzer/tomlplusplus/archive/${TOMLPLUSPLUS_SHA}.tar.gz -> ${PN}-tomlplusplus-${TOMLPLUSPLUS_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${HTTPLIB_SHA}.tar.gz -> ${PN}-httplib-${HTTPLIB_SHA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="xattr aio alsa cpu_flags_x86_avx2 cpu_flags_x86_avx512f debug io-uring jack malloc-trim membarrier doc pulseaudio test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/glib
	dev-libs/openssl
	dev-libs/xxhash
	media-libs/libepoxy
	media-libs/libglvnd[X]
	media-libs/libsamplerate
	media-libs/libsdl2
	net-libs/libpcap
	net-libs/libslirp
	sys-apps/dtc
	sys-libs/zlib
	x11-libs/gtk+:3
	x11-libs/pixman
	aio? ( dev-libs/libaio )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-libs/libpulse )
	jack? ( virtual/jack )
	io-uring? ( sys-libs/liburing )
	xattr? ( sys-apps/attr )"
RDEPEND="${DEPEND} ${PYTHON_DEPS}"
# shellcheck disable=SC2016
BDEPEND="dev-lang/perl
	dev-util/meson
	dev-util/ninja
	sys-apps/texinfo
	virtual/pkgconfig
	$(python_gen_impl_dep)
	$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')
	doc? (
			dev-python/sphinx
			dev-python/sphinx-rtd-theme
	)
	test? (
			dev-libs/glib[utils]
			sys-devel/bc
	)"

PATCHES=(
	"${FILESDIR}/${PN}-0001-make-target-list-xemu-work-w.patch"
	"${FILESDIR}/${PN}-0002-make-running-tests-configura.patch"
	"${FILESDIR}/${PN}-0003-ui-qemu-xemu-do-not-install-.patch"
	"${FILESDIR}/${PN}-0004-meson-let-version-get-stale.patch"
	"${FILESDIR}/${PN}-0005-allow-use-of-system-xxhash-h.patch"
	"${FILESDIR}/${PN}-0006-not-for-upstream-remove-trac.patch"
	"${FILESDIR}/${PN}-0007-not-for-upstream-remove-keym.patch"
)
DOCS=( README.md )

src_prepare() {
	{ rmdir genconfig && mv "${WORKDIR}/genconfig-${GENCONFIG_SHA}" genconfig; } || die
	{ rmdir hw/xbox/nv2a/thirdparty/nv2a_vsh_cpu && mv "${WORKDIR}/nv2a_vsh_cpu-${NV2A_VSH_CPU_SHA}" hw/xbox/nv2a/thirdparty/nv2a_vsh_cpu; } || die
	{ rmdir tests/fp/berkeley-softfloat-3 && mv "${WORKDIR}/berkeley-softfloat-3-${SOFTFLOAT_SHA}" tests/fp/berkeley-softfloat-3; } || die
	{ rmdir tests/fp/berkeley-testfloat-3 && mv "${WORKDIR}/berkeley-testfloat-3-${TESTFLOAT_SHA}" tests/fp/berkeley-testfloat-3; } || die
	{ rmdir tomlplusplus && mv "${WORKDIR}/tomlplusplus-${TOMLPLUSPLUS_SHA}" tomlplusplus; } || die
	{ rmdir ui/keycodemapdb && mv "${WORKDIR}/keycodemapdb-${KEYCODEMAPDB_SHA}" ui/keycodemapdb; } || die
	{ rmdir ui/thirdparty/httplib && mv "${WORKDIR}/cpp-httplib-${HTTPLIB_SHA}" ui/thirdparty/httplib; } || die
	{ rmdir ui/thirdparty/imgui && mv "${WORKDIR}/imgui-${IMGUI_SHA}" ui/thirdparty/imgui; } || die
	{ rmdir ui/thirdparty/implot && mv "${WORKDIR}/implot-${IMPLOT_SHA}" ui/thirdparty/implot; } || die
	echo "${PV}" > XEMU_VERSION || die
	echo master > XEMU_BRANCH || die
	touch XEMU_COMMIT || die
	default
}

src_configure() {
	local audio_drv_list=( "'sdl'," )
	local build_cflags=("-I${S}/ui/imgui")
	local debug_flag
	if use debug; then
		filter-flags '-O*'
		build_cflags+=(-O0 -g -DXEMU_DEBUG_BUILD=1)
		debug_flag=--enable-debug
	fi
	use alsa && audio_drv_list+=( "'alsa'," )
	use jack && audio_drv_list+=( "'jack'," )
	use pulseaudio && audio_drv_list+=( "'pa'," )
	local other_opts=(
		"$(use_enable alsa)"
		"$(use_enable debug debug-info)"
		"$(use_enable debug debug-tcg)"
		"$(use_enable doc docs)"
		"$(use_enable jack)"
		--disable-gettext
		"$(use_enable pulseaudio pa)"
		"$(use_enable xattr attr)"
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--disable-bsd-user
		--disable-containers # bug #732972
		--disable-guest-agent
		--disable-tcg-interpreter
		"--docdir=/usr/share/doc/${PF}/html"
		--host-cc="$(tc-getBUILD_CC)"
		"--libdir=/usr/$(get_libdir)"
		# From qemu ebuild
		# We support gnutls/nettle for crypto operations.  It is possible
		# to use gcrypt when gnutls/nettle are disabled (but not when they
		# are enabled), but it's not really worth the hassle.  Disable it
		# all the time to avoid automatically detecting it. #568856
		--disable-gcrypt
		# use prebuilt keymaps, bug #759604
		--disable-xkbcommon
	)
	local audio_drv_list_str="${audio_drv_list[*]}"
	local l=$((${#audio_drv_list_str}-1))
	audio_drv_list_str="${audio_drv_list_str:0:${l}}"
	audio_drv_list_str="${audio_drv_list_str// /}"
	econf \
		"$(use_enable aio linux-aio)" \
		"$(use_enable cpu_flags_x86_avx2 avx2)" \
		"$(use_enable cpu_flags_x86_avx512f avx512f)" \
		${debug_flag} \
		"$(use_enable io-uring linux-io-uring)" \
		"$(use_enable malloc-trim)" \
		"$(use_enable membarrier)" \
		"$(use_enable test tests)" \
		"--audio-drv-list=[${audio_drv_list_str}]" \
		--disable-blobs \
		--disable-qom-cast-debug \
		--disable-strip \
		--disable-werror \
		"--extra-cflags=-DXBOX=1 ${build_cflags[*]} -Wno-error=redundant-decls ${CFLAGS}" \
		--target-list=xemu \
		--with-git-submodules=ignore \
		--with-xxhash=system \
		"${other_opts[@]}"
}

src_compile() {
	MAKEOPTS+=" V=1"
	emake
}

src_test() {
	cd "${S}/build" || die
	pax-mark m "${PN}"* #515550
	emake check
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
