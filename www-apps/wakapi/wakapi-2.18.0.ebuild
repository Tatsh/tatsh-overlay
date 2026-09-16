# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A minimalist, self-hosted WakaTime-compatible backend for coding statistics"
HOMEPAGE="https://wakapi.dev/ https://github.com/muety/wakapi"
SRC_URI="https://github.com/muety/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror"

BDEPEND=">=dev-lang/go-1.18 app-arch/unzip"

src_compile() {
	go build -o "${PN}" || die
}

src_install() {
	dobin "${PN}"
	insinto /etc/"${PN}"
	newins config.default.yml config.yml
}

src_test() {
	env CGO_ENABLED=0 go test "$(go list ./... | grep -v 'github.com/muety/wakapi/scripts')" \
		-run ./...
}
