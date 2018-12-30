# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A library allowing to download single files from a remote zip archive"
HOMEPAGE="https://github.com/tihmstar/libfragmentzip"
MY_HASH="7f67a7a3d3380330900a293ee651abc96691dbac"
SRC_URI="https://github.com/tihmstar/libfragmentzip/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libzip
	net-misc/curl"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_HASH}"

PATCHES=( "${FILESDIR}/configure-ac.patch" )

DOCS=( AUTHORS ChangeLog LICENSE NEWS README )

src_prepare() {
	default
	eautoreconf
}

src_compile() {
	emake
}

src_install() {
	emake install DESTDIR="${D}"
	einstalldocs
}
