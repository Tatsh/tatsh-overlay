# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic

DESCRIPTION="3DS shader assembler and disassembler"
HOMEPAGE="https://github.com/neobrain/nihstro"
SHA="f4d8659decbfe5d234f04134b5002b82dc515a44"
SRC_URI="https://github.com/neobrain/nihstro/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="dev-libs/boost:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

DOCS=( Readme.md docs/instruction_set.md docs/nihcode_spec.md )

src_prepare() {
	sed -re 's/boost::swap/std::swap/g' -i src/assembler.cpp || die
	cmake_src_prepare
}

src_install() {
	insinto "/usr/include/${PN}"
	doins -r "include/${PN}/"*
	einstalldocs
	cmake_src_install
}
