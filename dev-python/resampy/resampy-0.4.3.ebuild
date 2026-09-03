# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Efficient signal resampling."
HOMEPAGE="https://pypi.org/project/resampy/ https://github.com/bmcfee/resampy"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/numba-0.53[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.17[${PYTHON_USEDEP}]"

BDEPEND="test? ( >=dev-python/scipy-1.1[${PYTHON_USEDEP}] )"

# The suite needs no plugins, so do not autoload the ones that happen to be
# installed. This is the EAPI 9 default.
EPYTEST_PLUGINS=()

src_prepare() {
	# Drop pytest-cov addopts; coverage reporting is not wanted here.
	sed -i '/^addopts = /d' setup.cfg || die
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
