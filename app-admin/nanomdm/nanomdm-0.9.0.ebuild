# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Minimalist Apple MDM server."
HOMEPAGE="https://github.com/micromdm/nanomdm"
SRC_URI="https://github.com/micromdm/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -o "${PN}" ./cmd/"${PN}"
	ego build -o nano2nano ./cmd/nano2nano
}

src_install() {
	dobin "${PN}" nano2nano
	einstalldocs
	dodoc -r docs
}
