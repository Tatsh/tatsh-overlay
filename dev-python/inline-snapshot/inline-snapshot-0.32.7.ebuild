# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Golden master/snapshot/approval testing library for Python"
HOMEPAGE="
	https://github.com/15r10nk/inline-snapshot
	https://pypi.org/project/inline-snapshot/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/asttokens-2.0.5[${PYTHON_USEDEP}]
	>=dev-python/executing-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-8.3.4[${PYTHON_USEDEP}]
	>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
# shellcheck disable=SC2016
RDEPEND+=" $(python_gen_cond_dep '>=dev-python/tomli-2.0.0[${PYTHON_USEDEP}]' python3_10)"

distutils_enable_tests pytest
