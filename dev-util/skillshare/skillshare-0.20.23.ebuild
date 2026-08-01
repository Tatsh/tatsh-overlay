# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="CLI to sync AI skills, rules, and prompts across Claude, Cursor, Codex, and other agent tools"
HOMEPAGE="https://github.com/runkids/skillshare https://skillshare.runkids.cc/"
SRC_URI="https://github.com/runkids/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT Apache-2.0 BSD BSD-2 ISC"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

BDEPEND=">=dev-lang/go-1.25"

src_compile() {
	CGO_ENABLED=0 go build -trimpath \
		-ldflags="-s -w -X main.version=${PV}" \
		-o skillshare ./cmd/skillshare || die
}

src_test() {
	go test ./... || die
}

src_install() {
	dobin skillshare
	einstalldocs
}
