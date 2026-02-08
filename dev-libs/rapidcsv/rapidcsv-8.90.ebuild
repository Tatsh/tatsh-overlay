# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C++ CSV parser library."
HOMEPAGE="https://github.com/d99kris/rapidcsv"
SRC_URI="https://github.com/d99kris/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	doheader src/rapidcsv.h
	einstalldocs
}
