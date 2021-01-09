# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="Complete x86/x64 JIT and AOT assembler for C++"
HOMEPAGE="https://github.com/asmjit/asmjit"
MY_HASH="70e80b18a5cc05d566e6c90dde200472c9325113"
SRC_URI="https://github.com/asmjit/asmjit/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_HASH}"
