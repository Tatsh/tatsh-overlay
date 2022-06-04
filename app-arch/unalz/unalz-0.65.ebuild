# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Unpack ALZ archives."
HOMEPAGE="https://web.archive.org/web/20201025202521/http://kippler.com/win/unalz/"
SRC_URI="https://web.archive.org/web/20150107141553if_/http://www.kippler.com/win/${PN}/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-system-zlib.patch"
	"${FILESDIR}/${PN}-types.patch"
	"${FILESDIR}/${PN}-system-bz2-01.patch"
)

S="${WORKDIR}/${PN}"

src_compile() {
	emake linux-utf8
}

src_install() {
	dobin "$PN"
}
