# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Minimal, Chocolatey-compatible NuGet server in a Django app."
HOMEPAGE="
	https://github.com/Tatsh/minchoc
	https://pypi.org/project/minchoc/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/django-5.2.11[${PYTHON_USEDEP}]
	>=dev-python/django-stubs-ext-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/ply-3.11[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-django[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
