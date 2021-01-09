# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Host-side script for the Open in mpv Chrome extension."
HOMEPAGE="https://github.com/Tatsh/open-in-mpv"
SRC_URI="https://github.com/Tatsh/open-in-mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/python-3.7.9
	media-video/mpv"
BDEPEND=""

src_install() {
	dobin host/open-in-mpv
	einstalldocs
}
