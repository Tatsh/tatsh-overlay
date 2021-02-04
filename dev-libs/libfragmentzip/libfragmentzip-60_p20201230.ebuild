# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A library allowing to download single files from a remote zip archive"
HOMEPAGE="https://github.com/tihmstar/libfragmentzip"
MY_SHA="6c8f5156558d83485c984b23a88e04845440fea2"
SRC_URI="https://github.com/tihmstar/libfragmentzip/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libzip
	net-misc/curl
	dev-libs/tihmstar-libgeneral"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=( "${FILESDIR}/configure-ac.patch" )

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
