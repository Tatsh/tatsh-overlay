# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="3DS shader assembler and disassembler"
HOMEPAGE="https://github.com/neobrain/nihstro"
MY_SHA="fd69de1a1b960ec296cc67d32257b0f9e2d89ac6"
SRC_URI="https://github.com/neobrain/nihstro/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/boost:="
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=( "${FILESDIR}/headers-fix.patch" )
DOCS=( Readme.md docs/instruction_set.md docs/nihcode_spec.md )

src_install() {
	insinto /usr/include/${PN}
	doins -r include/${PN}/*
	einstalldocs
	cmake_src_install
}
