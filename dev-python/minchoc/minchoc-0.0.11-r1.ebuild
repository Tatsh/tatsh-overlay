# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1 pypi

DESCRIPTION="Minimal, Chocolatey-compatible NuGet server in a Django app."
HOMEPAGE="https://github.com/Tatsh/minchoc"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/django-stubs-ext[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-django[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
