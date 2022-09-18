# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="3DS shader assembler and disassembler"
HOMEPAGE="https://github.com/neobrain/nihstro"
SHA="e924e21b1da60170f0f0a4e5a073cb7d579969c0"
SRC_URI="https://github.com/neobrain/nihstro/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="dev-libs/boost:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

DOCS=( Readme.md docs/instruction_set.md docs/nihcode_spec.md )

src_install() {
	insinto /usr/include/${PN}
	doins -r include/${PN}/*
	einstalldocs
	cmake_src_install
}
