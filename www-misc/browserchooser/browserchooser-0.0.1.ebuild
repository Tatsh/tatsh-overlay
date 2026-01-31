# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Pick a browser to use for a URL opened from a non-browser."
HOMEPAGE="https://github.com/Tatsh/browserchooser"
SRC_URI="https://github.com/Tatsh/browserchooser/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6[gui,widgets]"
RDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
