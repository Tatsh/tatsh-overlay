# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14,15} )
inherit meson python-single-r1

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

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="dev-lang/nasm"
# As of R78 VapourSynth installs its headers, libraries and plugin directory
# inside the Python package, and the build locates them through
# "import vapoursynth; vapoursynth.get_include()". The module therefore has to
# be built for the same implementation as this package.
# shellcheck disable=SC2016
DEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '>=media-video/vapoursynth-78[${PYTHON_USEDEP}]')
	>=sci-libs/fftw-3.3.4:="
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}
