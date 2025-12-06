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
IUSE="fuse"

DEPEND="dev-libs/openssl
	sys-libs/ncurses
	virtual/zlib"
RDEPEND="${DEPEND}
	fuse? ( sys-fs/fuse )"

DOCS=( ../README.md )

src_prepare() {
	# shellcheck disable=SC2016
	sed -re 's/@\$\(CC\)/$(CC)/g' -e 's/-O3\b//g' \
		-e 's/^CC\s+=(.*)/CC ?=\1/' \
		-e 's/^STRIP\s+=(.*)/STRIP ?=\1/' \
		-e 's/^install: all/install:/' \
		-i Makefile || die
	sed -re 's/ln -f/ln -sf/g' -i setup/install.sh || die
	default
}

src_compile() {
	emake STRIP=touch "HAVE_FUSE=$(usex fuse 1)" tools install.sh load-titles.sh INSTALL.txt
}

src_install() {
	sed -re "s|/usr/local|${ED}/usr|g" -i install.sh load-titles.sh Makefile.setup \
		templates.sed version.h || die
	emake STRIP=touch "HAVE_FUSE=$(usex fuse 1)" INSTALL_PATH="${ED}/usr" install
}
