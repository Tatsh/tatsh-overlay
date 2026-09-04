# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

RUST_MIN_VER="1.98.0"

inherit cargo desktop

DESCRIPTION="N64 emulator written in Rust."
HOMEPAGE="https://github.com/gopher64/gopher64"
PARALLEL_RDP_STANDALONE_SHA="388d70f5835b352d841d9d9e5a08c5de01470f41"
RCHEEVOS_SHA="2ad0b8672f68a48148620164510b963039e49eb1"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Themaister/parallel-rdp-standalone/archive/${PARALLEL_RDP_STANDALONE_SHA}.tar.gz -> ${PN}-parallel-rdp-standalone-${PARALLEL_RDP_STANDALONE_SHA:0:7}.tar.gz
	https://github.com/RetroAchievements/rcheevos/archive/${RCHEEVOS_SHA}.tar.gz -> ${PN}-rcheevos-${RCHEEVOS_SHA:0:7}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-crates.tar.xz"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD BZIP2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 UoI-NCSA
	Unicode-3.0 Unlicense ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/freetype
	media-libs/vulkan-loader"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_prepare() {
	rmdir parallel-rdp/parallel-rdp-standalone || die
	mv "${WORKDIR}/parallel-rdp-standalone-${PARALLEL_RDP_STANDALONE_SHA}" parallel-rdp/parallel-rdp-standalone || die
	rmdir retroachievements/rcheevos || die
	mv "${WORKDIR}/rcheevos-${RCHEEVOS_SHA}" retroachievements/rcheevos || die
	# Let the toolchain decide; -flto=thin conflicts with the system flags.
	sed -re '/lto =.*/d' -i Cargo.toml || die
	sed -re '/.*\.flag\("-flto=thin"\);/d' -i build.rs || die
	# There is no git checkout to describe when building from a release tarball.
	sed -e 's|panic!("Failed to get git describe");|format!("v{}", env!("CARGO_PKG_VERSION"))|' -i build.rs || die
	sed -e '/retroachievements_build\.compile/a\
\    println!("cargo:rustc-link-arg=-lvulkan");\
\    println!("cargo:rustc-link-arg=-lfreetype");' -i build.rs || die
	default
}

src_install() {
	cargo_src_install
	einstalldocs
	make_desktop_entry "${PN}"
}
