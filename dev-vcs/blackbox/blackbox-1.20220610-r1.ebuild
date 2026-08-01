# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Safely store secrets in Git/Mercurial/Subversion"
HOMEPAGE="https://github.com/StackExchange/blackbox"
SRC_URI="https://github.com/StackExchange/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

src_compile() {
	env GO111MODULE=on GOOS=linux go build -o "${PN}" \
		-ldflags "-s -w -X main.SHA=d45564d -X main.BuildTime=$(date +%s)" \
		github.com/StackExchange/blackbox/v2/cmd/blackbox
}

src_test() {
	go test ./... || die
}

src_install() {
	dobin "${PN}"
	dobin binv2/*
	einstalldocs
}
