# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="Stuff used in tsschecker."
HOMEPAGE="https://github.com/tihmstar/libgeneral"
MY_PN="${PN/tihmstar-}"
MY_SHA="b7802ee057ef760cced74b6ae68123e7ee7ce75f"
SRC_URI="https://github.com/tihmstar/${MY_PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
