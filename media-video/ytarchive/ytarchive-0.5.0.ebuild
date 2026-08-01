# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PV=$(ver_rs 3 -)
DESCRIPTION="Garbage YouTube live stream downloader."
HOMEPAGE="https://github.com/Kethsar/ytarchive"
SRC_URI="https://github.com/Kethsar/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"
S="${WORKDIR}/${PN}-${MY_PV}"
LICENSE="Apache-2.0 BSD-2 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

src_compile() {
	go build . || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
