# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast website link checker in Go"
HOMEPAGE="https://github.com/raviqqe/muffet"
SRC_URI="https://github.com/raviqqe/muffet/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Tests require network access to crawl real URLs.
RESTRICT="test"

src_compile() {
	go build . || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
