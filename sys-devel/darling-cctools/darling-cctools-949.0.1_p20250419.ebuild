# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {17..23} )

inherit cmake llvm-r2

SHA="d9456c221e1f462e17c0b3297748bc089d5a861e"
DESCRIPTION="Darling's fork of cctools and ld64 (Mach-O linker, ar, ranlib, lipo)."
HOMEPAGE="https://github.com/darlinghq/cctools-port https://www.darlinghq.org/"
SRC_URI="https://github.com/darlinghq/cctools-port/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cctools-port-${SHA}"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/blocksruntime"
RDEPEND="${DEPEND}"
# shellcheck disable=SC2016
BDEPEND="$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')"

PATCHES=(
	"${FILESDIR}/${PN}-0001-ld64-never-emit-chained-fixups-for-deltas.patch"
	"${FILESDIR}/${PN}-0002-ld64-add-USE_SYSTEM_BLOCKSRUNTIME-option.patch"
	"${FILESDIR}/${PN}-0003-Add-a-standalone-CMake-build-for-the-tools-Darling-u.patch"
)

src_prepare() {
	# unused or available as system packages
	rm -r cctools/ld64/src/3rd/BlocksRuntime cctools/libobjc2 || die
	cmake_src_prepare
}

src_configure() {
	# ld64 is built with -fblocks
	llvm_prepend_path "${LLVM_SLOT}"
	local -x CC="${CHOST}-clang" CXX="${CHOST}-clang++"
	local mycmakeargs=(
		-DCMAKE_INSTALL_BINDIR=libexec/darling-cctools/bin
		-DUSE_SYSTEM_BLOCKSRUNTIME=ON
	)
	cmake_src_configure
}
