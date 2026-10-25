# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="RDFa distiller/parser library"
HOMEPAGE="https://github.com/prrvchr/pyrdfa3 https://pypi.org/project/pyrdfa3/"
LICENSE="W3C"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/html5lib-1.1[${PYTHON_USEDEP}]
	>=dev-python/rdflib-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.3[${PYTHON_USEDEP}]"

# No tests in the PyPI sdist.
