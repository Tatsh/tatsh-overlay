# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Extract files from Wise installers without executing them"
HOMEPAGE="https://codeberg.org/CYBERDEV/REWise"
SRC_URI="https://codeberg.org/CYBERDEV/REWise/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/zlib:="
RDEPEND="${DEPEND}"
