# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A small, 0BSD-licensed metaprogramming library for C++17."
HOMEPAGE="https://github.com/MerryMage/mp"
SHA="b50053cef50385419c59fb3aebb78974547318bc"
SRC_URI="https://github.com/MerryMage/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	insinto /usr/include
	doins -r include/mp
	einstalldocs
}
