# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PN=$(ver_cut 1 "${PN}")

DESCRIPTION="Command line interface to WakaTime used by all WakaTime plugins"
HOMEPAGE="https://wakatime.com"
SRC_URI="https://github.com/${MY_PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="BSD MIT MPL-2.0 BSD-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# go.mod requires a newer toolchain than go-module.eclass depends on.
BDEPEND+=" >=dev-lang/go-1.26.6"

src_compile() {
	local mygoargs=(
		-v
		-work
		-x
		-tags release
		-ldflags "-X main.version=${PV}"
		-asmflags "-trimpath=${S}"
		-gcflags "-trimpath=${S}"
	)
	go build "${mygoargs[@]}" -o "${MY_PN}" || die
}

src_test() {
	go test -v -work -x || die
}

src_install() {
	dobin "${MY_PN}"
}
