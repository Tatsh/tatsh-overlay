# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Utilities for Vivisect."
HOMEPAGE="https://pypi.org/project/viv-utils/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-pyhton/funcy
	dev-python/intervaltree
	dev-python/python-flirt
	dev-python/typing-extensions
	dev-python/vivisect
	test? (
		dev-python/pytest-sugar
		dev-python/pytest-instafail
	)
"

distutils_enable_tests pytest
