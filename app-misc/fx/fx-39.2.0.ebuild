# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

MY_PV=$(ver_rs 3 -)
DESCRIPTION="Terminal JSON viewer."
HOMEPAGE="https://fx.wtf"
SRC_URI="https://github.com/antonmedv/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

S="${WORKDIR}/${PN}-${MY_PV}"
LICENSE="Apache-2.0 BSD-2 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
RESTRICT="mirror"

src_compile() {
	go build . || die
}

src_test() {
	go test ./... || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
