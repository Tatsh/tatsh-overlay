# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A set of command line tools to maniuplate Wii/Gamecube images."
HOMEPAGE="https://github.com/Wiimm/wiimms-iso-tools"
SHA="fc1c0b840cb3ac41ca6e4f1d5e16da12b47eab58"
SRC_URI="https://github.com/Wiimm/wiimms-iso-tools/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}/project"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl
	sys-libs/ncurses
	virtual/zlib"
RDEPEND="${DEPEND}"

DOCS=( ../README.md )

src_prepare() {
	# shellcheck disable=SC2016
	sed -re 's/@\$\(CC\)/$(CC)/g' -e 's/-O3\b//g' \
		-e 's/^CC\s+=(.*)/CC ?=\1/' \
		-e 's/^STRIP\s+=(.*)/STRIP ?=\1/' \
		-i Makefile
	default
}

src_compile() {
	local ED
	emake INSTALL_PATH="${ED}/usr" STRIP=touch
}
