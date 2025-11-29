# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Script to configure parameters for increasing system performance."
HOMEPAGE="https://gitlab.com/cscs/maxperfwiz"
SHA="68134696722510ef5ebd157fe44f4eac7c317166"
SRC_URI="https://gitlab.com/cscs/${PN}/-/archive/${SHA}/${PN}-${SHA}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="CSL-1"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )

src_install() {
	einstalldocs
	dobin "${PN}"
}
