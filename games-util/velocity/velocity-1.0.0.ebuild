# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

MY_PN="Velocity"

DESCRIPTION="Browse and edit Xbox 360 files such as STFS packages and FATX drives"
HOMEPAGE="https://github.com/hetelek/Velocity"
SRC_URI="https://github.com/hetelek/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/botan:3=
	dev-qt/qtbase:6[gui,network,widgets,xml]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	# Respect the user's flags, and find Botan with pkg-config instead of a fixed /usr/lib path.
	sed -e '/^QMAKE_CXXFLAGS = -O3$/d' -i XboxInternals/XboxInternals.pro || die
	sed -e 's|^\(\s*\)INCLUDEPATH += /usr/include/botan-3$|\1CONFIG += link_pkgconfig|' \
		-e 's|^\(\s*\)LIBS += /usr/lib/libbotan-3.so.0$|\1PKGCONFIG += botan-3|' \
		-i XboxInternals/XboxInternals.pro Velocity/Velocity.pro || die
	local pro
	for pro in XboxInternals/XboxInternals.pro Velocity/Velocity.pro; do
		grep -q 'PKGCONFIG += botan-3' "${pro}" || die "failed to switch ${pro} to pkg-config"
	done
}

src_configure() {
	local dir
	for dir in XboxInternals Velocity; do
		pushd "${dir}" > /dev/null || die
		eqmake6 CONFIG+=release
		popd > /dev/null || die
	done
}

src_compile() {
	# Velocity links against the static XboxInternals library.
	emake -C XboxInternals
	emake -C Velocity
}

src_install() {
	newbin "Velocity/build/${MY_PN}-Unix/release/${MY_PN}" "${PN}"
	newicon -s 128 Velocity/Images/Leaner24.png "${PN}.png"
	make_desktop_entry "${PN}" "${MY_PN}" "${PN}" "Utility;"
	einstalldocs
}
