# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

EGO_SUM=(
	"github.com/alessio/shellescape v1.4.1"
	"github.com/alessio/shellescape v1.4.1/go.mod"
	"github.com/dannav/hhmmss v1.0.0"
	"github.com/dannav/hhmmss v1.0.0/go.mod"
	"github.com/mattn/go-colorable v0.1.11"
	"github.com/mattn/go-colorable v0.1.11/go.mod"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/xhit/go-str2duration/v2 v2.1.0"
	"github.com/xhit/go-str2duration/v2 v2.1.0/go.mod"
	"golang.org/x/net v0.0.0-20210510120150-4163338589ed"
	"golang.org/x/net v0.0.0-20210510120150-4163338589ed/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.3.0"
	"golang.org/x/sys v0.3.0/go.mod"
)
go-module_set_globals
MY_PV=$(ver_rs 3 -)
DESCRIPTION="Garbage YouTube live stream downloader."
HOMEPAGE="https://github.com/Kethsar/ytarchive"
SRC_URI="https://github.com/Kethsar/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD-2 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	go build . || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
