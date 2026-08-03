# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
inherit meson python-any-r1

DESCRIPTION="Motion compensation, etc for VapourSynth."
HOMEPAGE="https://github.com/dubhatervapoursynth/vapoursynth-mvtools"
# Upstream moved to the dubhatervapoursynth organisation and tags use an
# underscore rather than a dot.
MY_PV="${PV//./_}"
SRC_URI="https://github.com/dubhatervapoursynth/${PN}/archive/v${MY_PV}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# meson needs an interpreter for python.find_installation(), but nothing here
# imports the VapourSynth module: the patch below takes the headers from
# pkg-config instead.
BDEPEND="${PYTHON_DEPS}
	dev-lang/nasm"
DEPEND=">=media-video/vapoursynth-74
	>=sci-libs/fftw-3.3.4"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-system-headers.patch" )
