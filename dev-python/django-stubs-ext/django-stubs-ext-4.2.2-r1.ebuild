# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Monkey-patching and extensions for django-stubs."
HOMEPAGE="https://pypi.org/project/django-stubs-ext/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
