# Copyright 2026 Gentoo Authors
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

BDEPEND="app-arch/unzip
	>=dev-lang/go-1.25.0:="

src_compile() {
	go build -ldflags "-X github.com/mbrt/gmailctl/cmd/gmailctl/cmd.version=${PV}" \
		"./cmd/${PN}" || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}

src_test() {
	go test -v ./... || die
}
