# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils flag-o-matic

DESCRIPTION="Original Xbox emulator."
HOMEPAGE="https://xemu.app/ https://github.com/mborgerson/xemu"
SHA="d7e926fc6342a28b4441df306b525b1aac016fad"
IMGUI_SHA="e18abe3619cfa0eced163c027d0349506814816c"
IMPLOT_SHA="dea3387cdcc1d6a7ee3607f8a37a9dce8a85224f"
KEYCODEMAPDB_SHA="d21009b1c9f94b740ea66be8e48a1d8ad8124023"
SOFTFLOAT_SHA="b64af41c3276f97f0e181920400ee056b9c88037"
TESTFLOAT_SHA="5a59dcec19327396a011a17fd924aed4fec416b3"
XXHASH_SHA="f2c52f1236a50d754b07f584ce4592de1df8c0f7"
SRC_URI="https://github.com/mborgerson/xemu/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/qemu-project/keycodemapdb/-/archive/${KEYCODEMAPDB_SHA}/keycodemapdb-${KEYCODEMAPDB_SHA}.tar.gz -> ${PN}-keycodemapdb-${KEYCODEMAPDB_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> ${PN}-implot-${IMPLOT_SHA:0:7}.tar.gz
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/${SOFTFLOAT_SHA}/berkeley-softfloat-3-${SOFTFLOAT_SHA}.tar.gz -> ${PN}-softfloat-${SOFTFLOAT_SHA:0:7}.tar.gz
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/${TESTFLOAT_SHA}/berkeley-testfloat-3-${TESTFLOAT_SHA}.tar.gz -> ${PN}-testfloat-${TESTFLOAT_SHA:0:7}.tar.gz
	https://github.com/Cyan4973/xxHash/archive/${XXHASH_SHA}.tar.gz -> ${PN}-xxhash-${XXHASH_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +lto"

DEPEND="media-libs/libepoxy
	media-libs/libsdl2
	net-libs/libslirp
	media-libs/libsamplerate
	dev-libs/openssl
	x11-libs/gtk+:3
	dev-libs/glib
	net-libs/libpcap
	|| ( media-sound/pulseaudio media-sound/apulse )
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/meson
	dev-util/ninja"

DOCS=( README.md )

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	{ rmdir hw/xbox/nv2a/xxHash && mv "${WORKDIR}/xxHash-${XXHASH_SHA}" hw/xbox/nv2a/xxHash; } || die
	{ rmdir tests/fp/berkeley-softfloat-3 && mv "${WORKDIR}/berkeley-softfloat-3-${SOFTFLOAT_SHA}" tests/fp/berkeley-softfloat-3; } || die
	{ rmdir tests/fp/berkeley-testfloat-3 && mv "${WORKDIR}/berkeley-testfloat-3-${TESTFLOAT_SHA}" tests/fp/berkeley-testfloat-3; } || die
	{ rmdir ui/imgui && mv "${WORKDIR}/imgui-${IMGUI_SHA}" ui/imgui; } || die
	{ rmdir ui/implot && mv "${WORKDIR}/implot-${IMPLOT_SHA}" ui/implot; } || die
	{ rmdir ui/keycodemapdb &&	mv "${WORKDIR}/keycodemapdb-${KEYCODEMAPDB_SHA}" ui/keycodemapdb; } || die
	default
}

src_configure() {
	local opts=()
	local build_cflags=("-I${S}/ui/imgui")
	if use debug; then
		filter-flags '-O*'
		build_cflags+=(-O0 -g -DXEMU_DEBUG_BUILD=1)
		opts+=(--enable-debug)
	else
		if use lto; then
			opts+=(--enable-lto)
		fi
	fi
	econf \
		--disable-strip \
		--disable-werror \
		--enable-slirp=system \
		"--extra-cflags=-DXBOX=1 ${build_cflags[@]} -Wno-error=redundant-decls ${CFLAGS}" \
		--target-list=i386-softmmu \
		--with-git-submodules=ignore \
		${opts[@]}
}

src_compile() {
	MAKEOPTS+=" V=1"
	emake qemu-system-i386
}

src_install() {
	newbin build/qemu-system-i386 xemu
	einstalldocs
}
