# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Enhanced (unofficial) qpxtool version."
HOMEPAGE="https://github.com/speed47/qpxtool"
MY_PV="$(ver_cut 1-3)"
MY_PL="$(ver_cut 4)"
SRC_URI="https://github.com/speed47/${PN}/archive/refs/tags/v${MY_PV}-pl${MY_PL}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +gui +internal-wt +liteon-probe"

DEPEND="gui? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsql:5
		dev-qt/qtwidgets:5
	)
	media-libs/libpng"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}-pl${MY_PL}"

src_prepare() {
	# Ignore invalid arguments
	sed -re '811s/exit//' \
		-e 's/.*strip --strip-unneeded.*/echo/g' \
		-e "s|lrelease|${EPREFIX}/usr/$(get_libdir)/qt5/bin/lrelease|g" \
		-i configure || die
	sed -re 's/^all:.*//' -e 's/\.gz//g' -e 's/^install:.*/install:/g' -i man/Makefile || die
	default
}

src_configure() {
	econf \
		"$(use_enable debug)" \
		"$(use_enable gui)" \
		"$(use_enable internal-wt)" \
		"$(use_enable liteon-probe)"
}
