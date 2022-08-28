# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils

DESCRIPTION="Qt-based UI for libqalculate."
HOMEPAGE="https://github.com/Qalculate/qalculate-qt"
SRC_URI="https://github.com/Qalculate/${PN}/releases/download/v${PV}/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

DEPEND=">=sci-libs/libqalculate-${PV}
	dev-qt/qtnetwork:=
	dev-qt/qtwidgets:="
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
