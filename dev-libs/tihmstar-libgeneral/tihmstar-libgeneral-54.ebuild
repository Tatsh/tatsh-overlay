# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="Stuff used in tsschecker."
HOMEPAGE="https://github.com/tihmstar/libgeneral"
MY_PN="${PN/tihmstar-}"
SRC_URI="https://github.com/tihmstar/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/configure-ac.patch" )

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	touch config.h.in
	default
	eautoreconf
}

src_compile() {
	emake
}
