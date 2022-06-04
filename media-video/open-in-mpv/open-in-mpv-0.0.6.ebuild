# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8,9} )
inherit python-single-r1

DESCRIPTION="Host-side script for the Open in mpv Chrome extension."
HOMEPAGE="https://github.com/Tatsh/open-in-mpv"
SRC_URI="https://github.com/Tatsh/open-in-mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="${PYTHON_DEPS}
	media-video/mpv"

src_install() {
	python_newscript "host/${PN}" "${PN}"
	einstalldocs
}
