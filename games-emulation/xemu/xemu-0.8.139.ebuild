# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
PYTHON_REQ_USE="ncurses,readline"

RUST_MIN_VER=1.96
DSP_PV=0.1.3
CRATES="
	aho-corasick@1.1.4
	allocator-api2@0.2.21
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.102
	ar_archive_writer@0.5.1
	arbitrary@1.4.2
	bitflags@1.3.2
	bitflags@2.11.1
	bumpalo@3.20.2
	cbindgen@0.29.3
	cc@1.2.63
	cfg-if@1.0.4
	chumsky@0.13.0
	clap@4.6.1
	clap_builder@4.6.0
	clap_derive@4.6.1
	clap_lex@1.1.0
	colorchoice@1.0.5
	cranelift-assembler-x64-meta@0.132.0
	cranelift-assembler-x64@0.132.0
	cranelift-bforest@0.132.0
	cranelift-bitset@0.132.0
	cranelift-codegen-meta@0.132.0
	cranelift-codegen-shared@0.132.0
	cranelift-codegen@0.132.0
	cranelift-control@0.132.0
	cranelift-entity@0.132.0
	cranelift-frontend@0.132.0
	cranelift-isle@0.132.0
	cranelift-jit@0.132.0
	cranelift-module@0.132.0
	cranelift-native@0.132.0
	cranelift-srcgen@0.132.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	either@1.15.0
	equivalent@1.0.2
	errno@0.3.14
	fastrand@2.4.1
	find-msvc-tools@0.1.9
	fnv@1.0.7
	foldhash@0.1.5
	foldhash@0.2.0
	getrandom@0.4.2
	gimli@0.33.0
	hashbrown@0.15.5
	hashbrown@0.16.1
	hashbrown@0.17.0
	heck@0.5.0
	id-arena@2.3.0
	indexmap@2.14.0
	is_terminal_polyfill@1.70.2
	itoa@1.0.18
	leb128fmt@0.1.0
	libc@0.2.185
	libm@0.2.16
	linux-raw-sys@0.12.1
	log@0.4.29
	logos-codegen@0.16.1
	logos-derive@0.16.1
	logos@0.16.1
	mach2@0.4.3
	memchr@2.8.0
	memmap2@0.2.3
	object@0.37.3
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	owo-colors@4.3.0
	prettyplease@0.2.37
	proc-macro2@1.0.106
	psm@0.1.31
	quote@1.0.45
	r-efi@6.0.0
	rayon-core@1.13.0
	rayon@1.12.0
	regalloc2@0.15.1
	regex-automata@0.4.14
	regex-syntax@0.8.10
	region@3.0.2
	rustc-hash@2.1.2
	rustix@1.1.4
	semver@1.0.28
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_spanned@1.1.1
	shlex@2.0.1
	smallvec@1.15.1
	stable_deref_trait@1.2.1
	stacker@0.1.24
	strsim@0.11.1
	syn@2.0.117
	target-lexicon@0.13.5
	tempfile@3.27.0
	toml@0.9.12+spec-1.1.0
	toml_datetime@0.7.5+spec-1.1.0
	toml_parser@1.1.2+spec-1.1.0
	toml_writer@1.1.1+spec-1.1.0
	unicode-ident@1.0.24
	unicode-segmentation@1.13.2
	unicode-xid@0.2.6
	utf8parse@0.2.2
	wasip2@1.0.3+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	wasmtime-internal-core@45.0.0
	wasmtime-internal-jit-icache-coherence@45.0.0
	windows-link@0.2.1
	windows-sys@0.52.0
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.7.15
	winnow@1.0.2
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-bindgen@0.57.1
	wit-component@0.244.0
	wit-parser@0.244.0
	zmij@1.0.21
"

inherit cargo fcaps flag-o-matic pax-utils python-r1 toolchain-funcs xdg-utils

DESCRIPTION="Original Xbox emulator"
HOMEPAGE="https://xemu.app/ https://github.com/xemu-project/xemu"
BERKELEY_SOFTFLOAT_SHA="b64af41c3276f97f0e181920400ee056b9c88037"
BERKELEY_TESTFLOAT_SHA="e7af9751d9f9fd3b47911f51a5cfd08af256a9ab"
GENCONFIG_SHA="42f85f9a2457e61d7e32542c07723565a284fcd6"
GLSLANG_SHA="16.2.0"
IMGUI_SHA="b911105fca3ca1b025706dd168e5798070f143a1"
IMPLOT_SHA="8553562dbb2025fd520f4bed57b094767b96c670"
KEYCODEMAPDB_SHA="f5772a62ec52591ff6870b7e8ef32482371f22c6"
NV2A_VSH_CPU_SHA="561fe80da57a881f89000256b459440c0178a7ce"
SPIRV_REFLECT_SHA="vulkan-sdk-1.4.335.0"
TOMLPLUSPLUS_SHA="30172438cee64926dc41fdd9c11fb3ba5b2ba9de"
VMA_SHA="3.3.0"
VOLK_SHA="1.4.304"
SRC_URI="https://github.com/xemu-project/xemu/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/qemu-project/keycodemapdb/-/archive/${KEYCODEMAPDB_SHA}/keycodemapdb-${KEYCODEMAPDB_SHA}.tar.bz2 -> ${PN}-keycodemapdb-${KEYCODEMAPDB_SHA:0:7}.tar.bz2
	https://github.com/abaire/nv2a_vsh_cpu/archive/${NV2A_VSH_CPU_SHA}.tar.gz -> ${PN}-nv2a_vsh_cpu-${NV2A_VSH_CPU_SHA:0:7}.tar.gz
	https://github.com/xemu-project/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> ${PN}-implot-${IMPLOT_SHA:0:7}.tar.gz
	https://github.com/marzer/tomlplusplus/archive/${TOMLPLUSPLUS_SHA}.tar.gz -> ${PN}-tomlplusplus-${TOMLPLUSPLUS_SHA:0:7}.tar.gz
	https://github.com/mborgerson/genconfig/archive/${GENCONFIG_SHA}.tar.gz -> ${PN}-genconfig-${GENCONFIG_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/refs/tags/${GLSLANG_SHA}.tar.gz -> ${PN}-glslang-${GLSLANG_SHA}.tar.gz
	https://github.com/zeux/volk/archive/refs/tags/${VOLK_SHA}.tar.gz -> ${PN}-volk-${VOLK_SHA}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Reflect/archive/refs/tags/${SPIRV_REFLECT_SHA}.tar.gz -> ${PN}-spirv-reflect-${SPIRV_REFLECT_SHA}.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/refs/tags/v${VMA_SHA}.tar.gz -> ${PN}-vulkanmemoryallocator-${VMA_SHA}.tar.gz
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/${BERKELEY_SOFTFLOAT_SHA}/berkeley-softfloat-3-${BERKELEY_SOFTFLOAT_SHA}.tar.bz2 -> ${PN}-berkeley-softfloat-3-${BERKELEY_SOFTFLOAT_SHA}.tar.bz2
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/${BERKELEY_TESTFLOAT_SHA}/berkeley-testfloat-3-${BERKELEY_TESTFLOAT_SHA}.tar.bz2 -> ${PN}-berkeley-testfloat-3-${BERKELEY_TESTFLOAT_SHA}.tar.bz2"

SRC_URI+="
	https://github.com/mborgerson/dsp56300/archive/refs/tags/v${DSP_PV}.tar.gz -> dsp56300-${DSP_PV}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xattr aio alsa debug io-uring jack malloc-trim membarrier pulseaudio test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/glib
	dev-libs/openssl
	dev-cpp/tomlplusplus
	dev-libs/xxhash
	media-libs/libepoxy
	media-libs/libglvnd[X]
	media-libs/libsamplerate
	media-libs/libsdl2
	net-misc/curl
	net-libs/libpcap
	net-libs/libslirp
	sys-apps/dtc
	virtual/zlib
	x11-libs/gtk+:3
	x11-libs/pixman
	aio? ( dev-libs/libaio )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-libs/libpulse )
	jack? ( virtual/jack )
	io-uring? ( sys-libs/liburing:= )
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
	"${FILESDIR}/${PN}-0005-not-for-upstream-remove-trac.patch"
	"${FILESDIR}/${PN}-0006-not-for-upstream-remove-keym.patch"
	"${FILESDIR}/${PN}-0007-not-for-upstream-misc-update.patch"
	"${FILESDIR}/${PN}-0008-add-target_long_bits.patch"
	"${FILESDIR}/${PN}-0009-uncomment-acpi-build.c.patch"
	"${FILESDIR}/${PN}-0010-fix-number-of-registered-aud.patch"
	"${FILESDIR}/${PN}-0011-fix-boot.patch"
	"${FILESDIR}/${PN}-0012-not-for-upstream-do-not-inst.patch"
)
DOCS=( README.md )

# shellcheck disable=SC2054
FILECAPS=( cap_net_raw,cap_net_admin=eip "usr/bin/${PN}" )

src_prepare() {
	mv "${WORKDIR}/genconfig-${GENCONFIG_SHA}" subprojects/genconfig || die
	mv "${WORKDIR}/nv2a_vsh_cpu-${NV2A_VSH_CPU_SHA}" subprojects/nv2a_vsh_cpu || die
	mv "${WORKDIR}/tomlplusplus-${TOMLPLUSPLUS_SHA}" subprojects/tomlplusplus || die
	mv "${WORKDIR}/keycodemapdb-${KEYCODEMAPDB_SHA}" subprojects//keycodemapdb || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" subprojects/imgui || die
	mv "${WORKDIR}/implot-${IMPLOT_SHA}" subprojects/implot || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" subprojects/glslang || die
	mv "${WORKDIR}/volk-${VOLK_SHA}" subprojects/volk || die
	mv "${WORKDIR}/SPIRV-Reflect-${SPIRV_REFLECT_SHA}" subprojects/SPIRV-Reflect || die
	mv "${WORKDIR}/VulkanMemoryAllocator-${VMA_SHA}" subprojects/VulkanMemoryAllocator || die
	mv "${WORKDIR}/berkeley-softfloat-3-${BERKELEY_SOFTFLOAT_SHA}" subprojects/berkeley-softfloat-3 || die
	cp subprojects/packagefiles/berkeley-softfloat-3/meson* subprojects/berkeley-softfloat-3 || die
	mv "${WORKDIR}/berkeley-testfloat-3-${BERKELEY_TESTFLOAT_SHA}" subprojects/berkeley-testfloat-3 || die
	cp subprojects/packagefiles/berkeley-testfloat-3/meson* subprojects/berkeley-testfloat-3 || die
	echo "${PV}" > XEMU_VERSION || die
	echo master > XEMU_BRANCH || die
	touch XEMU_COMMIT || die
	default
}

src_configure() {
	# Build the DSP FFI from source before Meson checks for it. Its fallback
	# downloads a prebuilt archive during configure.
	pushd "${WORKDIR}/dsp56300-${DSP_PV}" > /dev/null || die
	cargo_src_configure -p dsp56300-emu-ffi
	cargo_src_compile
	local cargo_libdir
	cargo_libdir="$(realpath "$(cargo_target_dir)")" || die
	mkdir -p "${T}/pkgconfig" || die
	cat > "${T}/pkgconfig/dsp56300-emu-ffi.pc" <<-EOF || die
		Name: dsp56300-emu-ffi
		Description: DSP56300 emulator C interface
		Version: ${DSP_PV}
		Libs: -L${cargo_libdir} -ldsp56300_emu_ffi -lpthread -ldl -lm
		Cflags: -I${PWD}/crates/emu-ffi/include
	EOF
	popd > /dev/null || die
	local -x PKG_CONFIG_PATH="${T}/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}"
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
		${debug_flag} \
		"$(use_enable io-uring linux-io-uring)" \
		"$(use_enable malloc-trim)" \
		"$(use_enable membarrier)" \
		"$(use_enable test tests)" \
		"--audio-drv-list=[${audio_drv_list_str}]" \
		 --disable-docs \
		--disable-qom-cast-debug \
		--disable-strip \
		--disable-werror \
		"--extra-cflags=-DXBOX=1 -DCONFIG_SOFTMMU ${build_cflags[*]} -Wno-error=redundant-decls ${CFLAGS}" \
		--target-list=xemu \
		"${other_opts[@]}"
}

src_compile() {
	MAKEOPTS+=" V=1"
	emake
}

src_install() {
	default
	rm -R "${D}/usr/share/qemu" || die
}

src_test() {
	cd "${S}/build" || die
	pax-mark m "${PN}"* #515550
	emake check
}

pkg_postinst() {
	fcaps_pkg_postinst
	xdg_desktop_database_update
	xdg_icon_cache_update
}
