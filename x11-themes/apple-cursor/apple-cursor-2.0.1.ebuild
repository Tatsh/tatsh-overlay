# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="macOS cursor theme."
HOMEPAGE="https://www.pling.com/p/1408466/"
SRC_URI="https://github.com/ful1e5/apple_cursor/releases/download/v${PV}/${TAR_NAME}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

TAR_NAME="macOS"

src_install() {
	insinto /usr/share/icons
	doins -r "${TAR_NAME}"
	einstalldocs
}
