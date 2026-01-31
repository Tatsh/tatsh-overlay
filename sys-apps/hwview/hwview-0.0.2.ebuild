# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hardware information viewer inspired by Redmond."
HOMEPAGE="https://github.com/Tatsh/hwview"
SRC_URI="https://github.com/Tatsh/hwview/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kde"

DEPEND="dev-qt/qtbase:6[concurrent,gui,widgets]
	virtual/udev"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		"-DHWVIEW_USE_KDE=$(usex kde)"
	)
	cmake_src_configure
}
