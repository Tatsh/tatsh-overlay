# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="Make JSON greppable"
HOMEPAGE="https://github.com/tomnomnom/gron"
SRC_URI="https://github.com/tomnomnom/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -ldflags "-X main.gronVersion=${PV}" -o "${PN}"
}

src_test() {
	ego test ./...
}

src_install() {
	dobin "${PN}"
	einstalldocs
	dodoc ADVANCED.mkd
	dofishcomp completions/gron.fish
}
