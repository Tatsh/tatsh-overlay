# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A set of command line tools to maniuplate files of various Nintendo titles."
HOMEPAGE="https://github.com/Wiimm/wiimms-szs-tools"
SHA="246fdb38d7c2fb3054b8f8528e11dc8f17691750"
SRC_URI="https://github.com/Wiimm/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"
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
		-e 's/^install: all/install:/' \
		-i Makefile
	sed -re 's/ln -f/ln -sf/g' -i setup/install.sh || die
	default
}

src_compile() {
	emake STRIP=touch tools install.sh INSTALL.txt
}

src_install() {
	sed -re "s|/usr/local|${ED}/usr|g" -i install.sh Makefile.setup templates.sed version.h || die
	emake STRIP=touch INSTALL_PATH="${ED}/usr" install
}
