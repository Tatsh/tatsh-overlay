# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )

inherit cmake-utils xdg-utils gnome2-utils python-single-r1 desktop

DESCRIPTION="A Qt and C++ GUI for radare2 reverse engineering framework"
HOMEPAGE="https://www.radare.org"
MY_HASH="ae35ac9d0812e1691502908cb3fae7bd88dbde75"
SRC_URI="https://github.com/radareorg/${PN}/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=dev-qt/qtcore-5.9.1:5
	>=dev-qt/qtgui-5.9.1:5
	>=dev-qt/qtsvg-5.9.1:5
	>=dev-qt/qtwidgets-5.9.1:5
	dev-qt/qtnetwork:5
	>=dev-util/radare2-3.4.1
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_HASH}/src"

src_configure() {
	local mycmakeargs=(
		CUTTER_ENABLE_PYTHON=yes
	)
	cmake-utils_src_configure
}

src_install() {
	dobin "${BUILD_DIR}/Cutter"
	doicon -s scalable "${S}/img/${PN}.svg"
	make_desktop_entry Cutter Cutter ${PN} Development
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
