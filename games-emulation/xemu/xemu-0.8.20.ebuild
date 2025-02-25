# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
PYTHON_REQ_USE="ncurses,readline"

inherit flag-o-matic pax-utils python-r1 toolchain-funcs xdg-utils

DESCRIPTION="Original Xbox emulator."
HOMEPAGE="https://xemu.app/ https://github.com/xemu-project/xemu"
GENCONFIG_SHA="42f85f9a2457e61d7e32542c07723565a284fcd6"
GLSLANG_SHA="vulkan-sdk-1.4.304.0"
HTTPLIB_SHA="0f1b62c2b3d0898cbab7aa685c2593303ffdc1a2"
IMGUI_SHA="80cbdab5ecd70db79917c448c333163995e605a5"
IMPLOT_SHA="006a1c23e5706bbe816968163b4d589162257a57"
KEYCODEMAPDB_SHA="f5772a62ec52591ff6870b7e8ef32482371f22c6"
NV2A_VSH_CPU_SHA="561fe80da57a881f89000256b459440c0178a7ce"
SOFTFLOAT_SHA="b64af41c3276f97f0e181920400ee056b9c88037"
SPIRV_REFLECT_SHA="vulkan-sdk-1.4.304.0"
TOMLPLUSPLUS_SHA="c635f218c0aefc801d9748841930365e54fe3089"
VMA_SHA="3.2.1"
VOLK_SHA="1.4.304"
SRC_URI="https://github.com/xemu-project/xemu/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/qemu-project/keycodemapdb/-/archive/${KEYCODEMAPDB_SHA}/keycodemapdb-${KEYCODEMAPDB_SHA}.tar.bz2 -> ${PN}-keycodemapdb-${KEYCODEMAPDB_SHA:0:7}.tar.bz2
	https://github.com/abaire/nv2a_vsh_cpu/archive/${NV2A_VSH_CPU_SHA}.tar.gz -> ${PN}-nv2a_vsh_cpu-${NV2A_VSH_CPU_SHA:0:7}.tar.gz
	https://github.com/xemu-project/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> ${PN}-implot-${IMPLOT_SHA:0:7}.tar.gz
	https://github.com/marzer/tomlplusplus/archive/${TOMLPLUSPLUS_SHA}.tar.gz -> ${PN}-tomlplusplus-${TOMLPLUSPLUS_SHA:0:7}.tar.gz
	https://github.com/mborgerson/genconfig/archive/${GENCONFIG_SHA}.tar.gz -> ${PN}-genconfig-${GENCONFIG_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${HTTPLIB_SHA}.tar.gz -> ${PN}-httplib-${HTTPLIB_SHA}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/refs/tags/${GLSLANG_SHA}.tar.gz -> ${PN}-glslang-${GLSLANG_SHA}.tar.gz
	https://github.com/zeux/volk/archive/refs/tags/${VOLK_SHA}.tar.gz -> ${PN}-volk-${VOLK_SHA}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Reflect/archive/refs/tags/${SPIRV_REFLECT_SHA}.tar.gz -> ${PN}-spirv-reflect-${SPIRV_REFLECT_SHA}.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/refs/tags/v${VMA_SHA}.tar.gz -> ${PN}-vulkanmemoryallocator-${VMA_SHA}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="xattr aio alsa cpu_flags_x86_avx2 debug io-uring jack malloc-trim membarrier pulseaudio test"
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
	dev-build/meson
	dev-build/ninja
	sys-apps/texinfo
	virtual/pkgconfig
	$(python_gen_impl_dep)
	$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')
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
	"${FILESDIR}/${PN}-0008-not-for-upstream-misc-update.patch"
)
DOCS=( README.md )

src_prepare() {
	mv "${WORKDIR}/genconfig-${GENCONFIG_SHA}" subprojects/genconfig || die
	mv "${WORKDIR}/cpp-httplib-${HTTPLIB_SHA}" subprojects/cpp-httplib || die
	mv "${WORKDIR}/nv2a_vsh_cpu-${NV2A_VSH_CPU_SHA}" subprojects/nv2a_vsh_cpu || die
	mv "${WORKDIR}/tomlplusplus-${TOMLPLUSPLUS_SHA}" subprojects/tomlplusplus || die
	mv "${WORKDIR}/keycodemapdb-${KEYCODEMAPDB_SHA}" subprojects//keycodemapdb || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" subprojects/imgui || die
	mv "${WORKDIR}/implot-${IMPLOT_SHA}" subprojects/implot || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" subprojects/glslang || die
	mv "${WORKDIR}/volk-${VOLK_SHA}" subprojects/volk || die
	mv "${WORKDIR}/SPIRV-Reflect-${SPIRV_REFLECT_SHA}" subprojects/SPIRV-Reflect || die
	mv "${WORKDIR}/VulkanMemoryAllocator-${VMA_SHA}" subprojects/VulkanMemoryAllocator || die
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
		${debug_flag} \
		"$(use_enable io-uring linux-io-uring)" \
		"$(use_enable malloc-trim)" \
		"$(use_enable membarrier)" \
		"$(use_enable test tests)" \
		"--audio-drv-list=[${audio_drv_list_str}]" \
		--disable-qom-cast-debug \
		--disable-strip \
		--disable-werror \
		"--extra-cflags=-DXBOX=1 -DCONFIG_SOFTMMU ${build_cflags[*]} -Wno-error=redundant-decls ${CFLAGS}" \
		--target-list=xemu \
		--with-xxhash=system \
		"${other_opts[@]}"
}

src_compile() {
	MAKEOPTS+=" V=1"
	emake
}

src_install() {
	default
	rm -fR "${D}/usr/"{include,lib,lib64} "${D}/usr/share/"{pkgconfig,qemu} "${D}/usr/bin/"{glslang,spirv}* || die
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
