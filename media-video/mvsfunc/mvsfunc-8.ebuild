# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-r1 python-utils-r1

DESCRIPTION="mawen1250's VapourSynth functions"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/mvsfunc"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc/archive/r8.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} >=media-video/vapoursynth-37"

S="${WORKDIR}/${PN}-r${PV}"

src_install () {
	python_foreach_impl python_domodule mvsfunc.py
}
