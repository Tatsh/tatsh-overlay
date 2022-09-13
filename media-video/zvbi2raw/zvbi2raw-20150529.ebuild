# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A quick-and-dirty tool for capturing vertical blanking interval data using libzvbi."
HOMEPAGE="https://github.com/codeman38/zvbi2raw"
SHA="765156d3c54cafd26d696f81cfa78fc12023a7bf"
SRC_URI="https://github.com/codeman38/zvbi2raw/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/zvbi"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_compile() {
	emake
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
