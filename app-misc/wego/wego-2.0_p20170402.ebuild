# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/schachmat/wego

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=415efdf
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Weather app for the terminal"
HOMEPAGE="https://github.com/schachmat/wego"
LICENSE="ISC"
SLOT="0"
IUSE=""

DEPEND="dev-go/go-colorable
	dev-go/ingo
	dev-go/go-runewidth"

DOCS=( "src/${EGO_PN}/README.md" )

src_install() {
	mkdir pkg
	golang-build_src_install
	einstalldocs
	dobin bin/*
}
