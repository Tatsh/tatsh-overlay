# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )
# 0.5.0 ships as a wheel following https://vapoursynth.com/doc/packaging.html,
# so the plugin installs into the vapoursynth package rather than a plugin dir
# of its own. The project is named after that convention on PyPI.
PYPI_PN="vapoursynth-${PN}"

inherit distutils-r1 pypi

DESCRIPTION="Scene change detection plugin for VapourSynth."
HOMEPAGE="https://tatsh.github.io/scenechange/ https://github.com/Tatsh/scenechange"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-video/vapoursynth[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
# The hatchling hook drives meson itself, so both have to be present as
# ordinary build tools.
# shellcheck disable=SC2016
BDEPEND=">=dev-build/meson-1.3.0
	>=dev-build/ninja-1.11.0
	$(python_gen_cond_dep '>=dev-python/packaging-25.0[${PYTHON_USEDEP}]')"
