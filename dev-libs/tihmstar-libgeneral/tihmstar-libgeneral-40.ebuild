# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="Stuff used in tsschecker."
HOMEPAGE="https://github.com/tihmstar/libgeneral"
MY_PN="${PN/tihmstar-}"
MY_SHA="210aa949151ce9851a44ab8623667dc749a5c74e"
SRC_URI="https://github.com/tihmstar/${MY_PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-${MY_SHA}"

PATCHES=( "${FILESDIR}/configure-ac.patch" )

src_prepare() {
	touch config.h.in
	default
	eautoreconf
}

src_compile() {
	emake
}
