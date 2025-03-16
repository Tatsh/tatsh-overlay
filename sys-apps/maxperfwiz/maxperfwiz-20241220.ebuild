# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Script that assists the user in configuring a selection of parameters with the purpose of increasing system performance."
HOMEPAGE="https://gitlab.com/cscs/maxperfwiz"
SHA="68134696722510ef5ebd157fe44f4eac7c317166"
SRC_URI="https://gitlab.com/cscs/${PN}/-/archive/${SHA}/${PN}-${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="CSL-1"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	einstalldocs
	dobin "${PN}"
}
