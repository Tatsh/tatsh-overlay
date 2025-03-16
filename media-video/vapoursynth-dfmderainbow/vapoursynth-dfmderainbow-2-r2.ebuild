# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit python-r1

DESCRIPTION="Derainbow function for VapourSynth."
HOMEPAGE="https://github.com/dubhater/vapoursynth-dfmderainbow"
SRC_URI="https://github.com/dubhater/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="media-video/vapoursynth[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	media-video/vapoursynth-fluxsmooth
	media-video/vapoursynth-minideen
	media-video/vapoursynth-msmoosh"

DOCS=( readme.rst )

src_prepare() {
	sed -re 's/vs\.get_core\(\)/vs.core/g' -i dfmderainbow.py || die
	default
}

src_install() {
	python_foreach_impl python_domodule dfmderainbow.py
	einstalldocs
}
