# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit golang-base go-module

EGO_SUM=(
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/mattn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

DESCRIPTION="Colorable writer for Windows."
HOMEPAGE="https://github.com/mattn/go-colorable"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

DEPEND="dev-go/go-isatty"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-f6c00982823144337e56cdb71c712eaac151d29c"

src_install() {
	insinto $(get_golibdir)/src/github.com/mattn/${PN}
	doins *.go
	einstalldocs
}
