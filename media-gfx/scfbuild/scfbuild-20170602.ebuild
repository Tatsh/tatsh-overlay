# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Create color fonts from SVGs on the command line"
HOMEPAGE="https://github.com/eosrei/scfbuild"
SRC_URI="https://github.com/eosrei/scfbuild/archive/master.zip -> ${P}.zip"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/fonttools-3.0
	media-gfx/fontforge[python]"

S="${WORKDIR}/${PN}-master"

src_install() {
	exeinto /usr/bin
	doexe "bin/${PN}"
	insinto /usr/$(get_libdir)/python2.7/site-packages
	doins -r "$PN"
	default
}
