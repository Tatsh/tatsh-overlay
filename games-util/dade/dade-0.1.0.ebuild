# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

PYPI_VERIFY_REPO="https://github.com/Tatsh/dade"

inherit distutils-r1 pypi

DESCRIPTION="Extract and convert assets from a collection of PC and console video games."
HOMEPAGE="https://tatsh.github.io/dade/ https://github.com/Tatsh/dade"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/7zip
	app-arch/unshield
	app-cdr/cdrtools
	>=dev-python/anyio-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.5.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-50.0.1[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
	>=dev-python/mido-1.3.3[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.2.6[${PYTHON_USEDEP}]
	>=dev-python/pillow-12.3.0[${PYTHON_USEDEP}]
	>=dev-python/pylzham-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyopencl-2024.1[${PYTHON_USEDEP}]
	>=dev-python/rich-15.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.16.0[${PYTHON_USEDEP}]
	>=dev-util/nvidia-cuda-toolkit-12.6.3[${PYTHON_USEDEP}]
	games-util/gdiextract
	games-util/spvr2png
	media-gfx/imagemagick
	media-libs/fontconfig
	media-sound/fluidsynth
	media-sound/vgmstream
"
BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/mock-5.2.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-asyncio-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-mock-3.15.1[${PYTHON_USEDEP}]
	)
"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

EPYTEST_PLUGINS=( pytest-asyncio pytest-mock )
distutils_enable_tests pytest
