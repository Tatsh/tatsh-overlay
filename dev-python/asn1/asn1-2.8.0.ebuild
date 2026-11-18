# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Simple ASN.1 encoder and decoder"
HOMEPAGE="https://github.com/andrivet/python-asn1 https://pypi.org/project/asn1/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_IGNORE=(
	# --doctest-modules in setup.cfg imports these; they are not tests.
	docs
	examples
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
