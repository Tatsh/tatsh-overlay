# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils desktop

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

DOCS=( resources/other/LICENSE VERSION resources/README.txt README.md )

src_prepare() {
	# Don't allow dpkg to run
	sed 's/dpkg/somethingnotinpath123/g' -i cen64-qt.pro
	default
}

src_compile() {
	eqmake5
	emake
}

src_install() {
	einstalldocs
	rm -R resources/other/ resources/README.txt
	newicon resources/images/cen64.png "${PN}.png"
	domenu "resources/${PN}.desktop" && rm "resources/${PN}.desktop"
	insinto "/usr/share/${PN}"
	doman "resources/${PN}.6" && rm "resources/${PN}.6"
	doins -r resources
	exeinto "/usr/share/${PN}"
	doexe "${PN}"
	dosym "/usr/share/${PN}/${PN}" "/usr/bin/${PN}"
}
