# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9,10} )

inherit python-r1

DESCRIPTION="Derainbow function for VapourSynth."
HOMEPAGE="https://github.com/dubhater/vapoursynth-astdr"
SRC_URI="https://github.com/dubhater/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-video/vapoursynth"

DOCS=( readme.rst )

src_install() {
	python_foreach_impl python_domodule ASTDR.py
	einstalldocs
}
