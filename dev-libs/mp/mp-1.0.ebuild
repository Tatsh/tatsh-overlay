# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A small, 0BSD-licensed metaprogramming library for C++17."
HOMEPAGE="https://github.com/MerryMage/mp"
SRC_URI="https://github.com/MerryMage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( README.md )

src_install() {
	insinto /usr/include
	doins -r include/mp
	einstalldocs
}
