# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="A CPU emulator framework based on QEMU."
HOMEPAGE="https://github.com/unicorn-engine/unicorn"
MY_SHA="3134f3302981298e8c53ef6b000959c31c6818af"
SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicorn_targets_x86
	+unicorn_targets_arm
	+unicorn_targets_aarch64
	unicorn_targets_m68k
	unicorn_targets_mips
	unicorn_targets_sparc"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=( "${FILESDIR}/${PN}-yuzu-reg_esr.patch" )

src_configure() {
	local archs=()
	use unicorn_targets_x86 && archs+=( x86 )
	use unicorn_targets_arm && archs+=( arm )
	use unicorn_targets_aarch64 && archs+=( aarch64 )
	use unicorn_targets_m68k && archs+=( m68k )
	use unicorn_targets_mips && arch+=( mips )
	use unicorn_targets_sparc && arch+=( sparc )
	local mycmakeargs=( -DUNICORN_ARCH=${archs[*]} -DBUILD_SHARED_LIBS=OFF )
	cmake_src_configure
}
