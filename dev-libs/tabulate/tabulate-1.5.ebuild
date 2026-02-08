# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Table maker for modern C++."
HOMEPAGE="https://github.com/p-ranav/tabulate"
SRC_URI="https://github.com/p-ranav/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	doheader -r include/tabulate
	einstalldocs
}
