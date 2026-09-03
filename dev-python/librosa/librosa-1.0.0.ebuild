# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

PYPI_VERIFY_REPO="https://github.com/librosa/librosa"

inherit distutils-r1 pypi

DESCRIPTION="Python library for audio and music analysis."
HOMEPAGE="https://pypi.org/project/librosa/ https://librosa.org/"
# The PyPI sdist ships the test modules but not the test audio or baseline
# images; those only exist in the git tag. Both archives extract to ${P}/, so the
# git tag is unpacked first and the canonical PyPI sources win for shared files.
SRC_URI="test? ( https://github.com/librosa/librosa/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz )
	${SRC_URI}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/decorator-5.2.1[${PYTHON_USEDEP}]
	>=dev-python/joblib-1.2[${PYTHON_USEDEP}]
	>=dev-python/lazy-loader-0.3[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.5[${PYTHON_USEDEP}]
	>=dev-python/numba-0.61.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/pooch-1.7[${PYTHON_USEDEP}]
	>=dev-python/scikit-learn-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/soundfile-0.12.1[${PYTHON_USEDEP}]
	>=dev-python/soxr-1.0.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	>=dev-python/matplotlib-3.10.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-23.2[${PYTHON_USEDEP}]
	>=dev-python/resampy-0.4.3[${PYTHON_USEDEP}]
	dev-python/samplerate[${PYTHON_USEDEP}]
)"

# The suite runs pytest-mpl image comparisons; conftest.py turns them off by
# itself on matplotlib older than 3.11.
EPYTEST_PLUGINS=( pytest-mpl )

python_prepare_all() {
	# Drop the coverage reporting, which would need pytest-cov, and skip the
	# tests upstream marks as needing network access.
	sed -i '/^addopts = /s/ --cov-report term-missing --cov librosa --cov-report=xml/ --librosa-isolation/' \
		setup.cfg || die
	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
