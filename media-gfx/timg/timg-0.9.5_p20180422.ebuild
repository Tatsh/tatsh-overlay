# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A terminal image viewer"
HOMEPAGE="https://github.com/hzeller/timg"
MY_HASH="4a300cfe9c159ffb5d357b41b3c69c57219da9e8"
SRC_URI="https://github.com/hzeller/timg/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/graphicsmagick"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( ../README.md ../LICENSE )

S="${WORKDIR}/${PN}-${MY_HASH}/src"

src_prepare() {
	sed -e 's/=/?=/g' -i Makefile
	default
}

src_compile() {
	emake CXXFLAGS="$(GraphicsMagick++-config --cppflags) $CXXFLAGS"
}

src_install() {
	mkdir -p "${D}/usr/bin"
	emake install PREFIX="${D}/usr"
	einstalldocs
}
