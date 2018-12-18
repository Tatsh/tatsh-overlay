# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

DESCRIPTION="A customizable frontend for Cen64."
HOMEPAGE="https://github.com/dh4/cen64-qt"
MY_V="${PV//.}"
MY_V="${MY_V/_/-}"
SRC_URI="https://github.com/dh4/cen64-qt/archive/${MY_V}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${MY_V}"

RDEPEND="games-emulation/cen64"
DEPEND="${RDEPEND} \
	dev-qt/qtwidgets \
	dev-qt/qtcore \
	dev-qt/qtnetwork \
	dev-qt/qtxml \
	dev-qt/qtsql \
	dev-libs/quazip"
BDEPEND=""

src_prepare() {
	# Don't allow dpkg to run
	sed 's/dpkg/somethingnotinpath123/g' -i cen64-qt.pro
	default
}

src_compile() {
	eqmake5
	emake
}
