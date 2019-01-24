# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4..7} )
inherit distutils-r1

DESCRIPTION="An anti-forensic kill-switch that waits for a change on your USB ports and then immediately shuts down your computer."
HOMEPAGE="https://github.com/hephaest0s/usbkill"
MY_HASH="d3df79edab0c1dcec4b56468958c17a5c5dc6dce"
SRC_URI="https://github.com/hephaest0s/usbkill/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_HASH}"
