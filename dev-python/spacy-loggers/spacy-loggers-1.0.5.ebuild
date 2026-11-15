# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Logging utilities for SpaCy"
HOMEPAGE="https://github.com/explosion/spacy-loggers"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

S="${WORKDIR}/${PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# The tests import spacy, which depends on this package.
BDEPEND="test? ( dev-python/spacy[${PYTHON_USEDEP}] )"

EPYTEST_DESELECT=(
	# The test config passes progress_bar = "true", which current confection rejects as not a bool.
	spacy_loggers/tests/test_chain.py::test_load_from_config
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
