# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A set of command line tools to maniuplate files of various Nintendo titles."
HOMEPAGE="https://github.com/Wiimm/wiimms-szs-tools"
SHA="b5b1fe7fc0cf460d6204c18ba7bb4c40f7597efa"
SRC_URI="https://github.com/Wiimm/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl
	sys-libs/ncurses
	sys-libs/zlib"
RDEPEND="${DEPEND}"

DOCS=( ../README.md )

S="${WORKDIR}/${PN}-${SHA}/project"

src_prepare() {
	# shellcheck disable=SC2016
	sed -re 's/@\$\(CC\)/$(CC)/g' -e 's/-O3\b//g' \
		-e 's/^CC\s+=(.*)/CC ?=\1/' \
		-e 's/^STRIP\s+=(.*)/STRIP ?=\1/' \
		-i Makefile
	default
}

src_compile() {
	emake INSTALL_PATH="${ED}/usr" STRIP=touch
}
