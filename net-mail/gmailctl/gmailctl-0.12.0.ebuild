# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Declarative configuration for Gmail filters"
HOMEPAGE="https://github.com/mbrt/gmailctl"
SRC_URI="https://github.com/mbrt/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	go build "./cmd/${PN}"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}

src_test() {
	go test -v ./...
}
