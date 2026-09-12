# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="DiscImageCreator"

DESCRIPTION="Dump optical discs with subchannel and error correction data."
HOMEPAGE="https://github.com/saramibreak/DiscImageCreator"
SRC_URI="https://github.com/saramibreak/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/libarchive:=
	dev-libs/openssl:=
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

src_install() {
	meson_src_install
	einstalldocs
}
