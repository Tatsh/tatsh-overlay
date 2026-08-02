# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="A beautiful reStructuredText renderer for rich."
HOMEPAGE="https://github.com/wasi-master/rich-rst"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/docutils[${PYTHON_USEDEP}]
	>=dev-python/rich-12.0.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
