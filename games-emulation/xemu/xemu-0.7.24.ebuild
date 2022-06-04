# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
PYTHON_REQ_USE="ncurses,readline"

inherit eutils flag-o-matic python-r1 xdg-utils

DESCRIPTION="Original Xbox emulator."
HOMEPAGE="https://xemu.app/ https://github.com/mborgerson/xemu"
GENCONFIG_SHA="5da3fd2463288d9e048dbf3ea41f2bad0a4287a8"
IMGUI_SHA="c71a50deb5ddf1ea386b91e60fa2e4a26d080074"
IMPLOT_SHA="b47c8bacdbc78bc521691f70666f13924bb522ab"
KEYCODEMAPDB_SHA="d21009b1c9f94b740ea66be8e48a1d8ad8124023"
SOFTFLOAT_SHA="b64af41c3276f97f0e181920400ee056b9c88037"
SLIRP_SHA="a88d9ace234a24ce1c17189642ef9104799425e0"
TESTFLOAT_SHA="5a59dcec19327396a011a17fd924aed4fec416b3"
TOMLPLUSPLUS_SHA="27816dbbd168a84a0a7a252d7d75b0ca4dc1e073"
SRC_URI="https://github.com/mborgerson/xemu/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/qemu-project/keycodemapdb/-/archive/${KEYCODEMAPDB_SHA}/keycodemapdb-${KEYCODEMAPDB_SHA}.tar.gz -> ${PN}-keycodemapdb-${KEYCODEMAPDB_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> ${PN}-implot-${IMPLOT_SHA:0:7}.tar.gz
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/${SOFTFLOAT_SHA}/berkeley-softfloat-3-${SOFTFLOAT_SHA}.tar.gz -> ${PN}-softfloat-${SOFTFLOAT_SHA:0:7}.tar.gz
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/${TESTFLOAT_SHA}/berkeley-testfloat-3-${TESTFLOAT_SHA}.tar.gz -> ${PN}-testfloat-${TESTFLOAT_SHA:0:7}.tar.gz
	https://github.com/mborgerson/genconfig/archive/${GENCONFIG_SHA}.tar.gz -> ${PN}-genconfig-${GENCONFIG_SHA:0:7}.tar.gz
	https://github.com/marzer/tomlplusplus/archive/${TOMLPLUSPLUS_SHA}.tar.gz -> ${PN}-tomlplusplus-${TOMLPLUSPLUS_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="xattr aio alsa cpu_flags_x86_avx2 cpu_flags_x86_avx512f debug io-uring jack +lto malloc-trim membarrier nls doc pulseaudio sdl test"
REQUIRED_USE="debug? ( !lto  )"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/glib
	dev-libs/libxml2
	dev-libs/openssl
	dev-libs/xxhash
	media-libs/libepoxy
	media-libs/libsamplerate
	media-libs/libsdl2
	net-libs/libpcap
	net-libs/libslirp
	sys-libs/zlib
	virtual/opengl
	x11-libs/gtk+:3
	x11-libs/pixman
	aio? ( dev-libs/libaio )
	alsa? ( media-libs/alsa-lib )
	io-uring? ( sys-libs/liburing )
	jack? ( virtual/jack )
	pulseaudio? ( media-sound/pulseaudio )
	xattr? ( sys-apps/attr )"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/perl
	dev-util/meson
	dev-util/ninja
	sys-apps/texinfo
	virtual/pkgconfig
	$(python_gen_impl_dep)
	doc? (
			dev-python/sphinx
			dev-python/sphinx_rtd_theme
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
	{ rmdir tests/fp/berkeley-softfloat-3 && mv "${WORKDIR}/berkeley-softfloat-3-${SOFTFLOAT_SHA}" tests/fp/berkeley-softfloat-3; } || die
	{ rmdir tests/fp/berkeley-testfloat-3 && mv "${WORKDIR}/berkeley-testfloat-3-${TESTFLOAT_SHA}" tests/fp/berkeley-testfloat-3; } || die
	{ rmdir tomlplusplus && mv "${WORKDIR}/tomlplusplus-${TOMLPLUSPLUS_SHA}" tomlplusplus; } || die
	{ rmdir ui/keycodemapdb && mv "${WORKDIR}/keycodemapdb-${KEYCODEMAPDB_SHA}" ui/keycodemapdb; } || die
	{ rmdir ui/thirdparty/imgui && mv "${WORKDIR}/imgui-${IMGUI_SHA}" ui/thirdparty/imgui; } || die
	{ rmdir ui/thirdparty/implot && mv "${WORKDIR}/implot-${IMPLOT_SHA}" ui/thirdparty/implot; } || die
	echo "${PV}" > XEMU_VERSION || die
	echo master > XEMU_BRANCH || die
	touch XEMU_COMMIT || die
	default
}

src_configure() {
	local audio_drv_list=()
	local build_cflags=("-I${S}/ui/imgui")
	local debug_flag
	if use debug; then
		filter-flags '-O*'
		build_cflags+=(-O0 -g -DXEMU_DEBUG_BUILD=1)
		debug_flag=--enable-debug
	fi
	use alsa && audio_drv_list+=( alsa )
	use jack && audio_drv_list+=( jack )
	use pulseaudio && audio_drv_list+=( pa )
	use sdl && audio_drv_list+=( sdl )
	local other_opts=(
		$(use_enable debug debug-info)
		$(use_enable debug debug-tcg)
		$(use_enable doc docs)
		$(use_enable nls gettext)
		$(use_enable xattr attr)
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--disable-bsd-user
		--disable-containers # bug #732972
		--disable-guest-agent
		--disable-tcg-interpreter
		--docdir=/usr/share/doc/${PF}/html
		--host-cc="$(tc-getBUILD_CC)"
		--libdir=/usr/$(get_libdir)
		# From qemu ebuild
		# We support gnutls/nettle for crypto operations.  It is possible
		# to use gcrypt when gnutls/nettle are disabled (but not when they
		# are enabled), but it's not really worth the hassle.  Disable it
		# all the time to avoid automatically detecting it. #568856
		--disable-gcrypt
		# use prebuilt keymaps, bug #759604
		--disable-xkbcommon
		--enable-libxml2
	)
	econf \
		$(use_enable aio linux-aio) \
		$(use_enable cpu_flags_x86_avx2 avx2) \
		$(use_enable cpu_flags_x86_avx512f avx512f) \
		${debug_flag} \
		$(use_enable io-uring linux-io-uring) \
		$(use_enable lto) \
		$(use_enable malloc-trim) \
		$(use_enable membarrier) \
		$(use_enable test tests) \
		"--audio-drv-list=${audio_drv_list[*]}" \
		--disable-blobs \
		--disable-qom-cast-debug \
		--disable-strip \
		--disable-werror \
		--enable-slirp=system \
		"--extra-cflags=-DXBOX=1 ${build_cflags[@]} -Wno-error=redundant-decls ${CFLAGS}" \
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
	cd "${S}/build"
	pax-mark m "${PN}"* #515550
	emake check
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
