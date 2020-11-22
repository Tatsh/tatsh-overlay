# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit golang-base go-module

EGO_SUM=(
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42 h1:vEOn+mP2zCOVzKckCZy6YsCtDblrpj/w7B9nxGNELpg="
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
)
go-module_set_globals

SRC_URI="https://github.com/mattn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
DESCRIPTION="isatty for Go."
HOMEPAGE="https://github.com/mattn/go-isatty"
LICENSE="MIT"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}-28b35a325e89623a31764c9bcfb74f4e6c9f105c"

src_compile() {
	go build -work -o lib/${PN}.a ./ || die
}

src_install() {
	insinto $(get_golibdir)/src/github.com/mattn/${PN}
	doins *.go
	insinto $(get_golibdir)/pkg/$(go env GOOS)_$(go env GOARCH)/github.com/mattn
	doins lib/${PN}.a
	einstalldocs
}
