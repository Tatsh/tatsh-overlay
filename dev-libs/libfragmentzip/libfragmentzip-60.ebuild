# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A library allowing to download single files from a remote zip archive"
HOMEPAGE="https://github.com/tihmstar/libfragmentzip"
MY_SHA="120447d0f410dffb49948fa155467fc5d91ca3c8"
SRC_URI="https://github.com/tihmstar/libfragmentzip/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libzip
	net-misc/curl
	dev-libs/tihmstar-libgeneral"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=( "${FILESDIR}/configure-ac.patch" )

DOCS=( AUTHORS ChangeLog LICENSE NEWS README )

src_prepare() {
	touch config.h.in
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
