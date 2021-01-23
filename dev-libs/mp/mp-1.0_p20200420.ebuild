# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A small, 0BSD-licensed metaprogramming library for C++17."
HOMEPAGE="https://github.com/MerryMage/mp"
MY_SHA="649fde1e814f9ce5b04d7ddeb940244d9f63cb2f"
SRC_URI="https://github.com/MerryMage/${PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

src_install() {
	insinto /usr/include
	doins -r include/mp
	einstalldocs
}
