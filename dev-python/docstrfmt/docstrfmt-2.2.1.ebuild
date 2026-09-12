# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="A formatter for Sphinx flavored reStructuredText."
HOMEPAGE="https://github.com/LilSpazJoekp/docstrfmt https://pypi.org/project/docstrfmt/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# Upstream also lists docutils-stubs and types-docutils as runtime
# dependencies, but they only ship type stubs and are not imported.
# shellcheck disable=SC2016
RDEPEND="
	>=dev-python/black-24[${PYTHON_USEDEP}]
	>=dev-python/click-8[${PYTHON_USEDEP}]
	>=dev-python/coverage-7.11.0[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.21[${PYTHON_USEDEP}]
	>=dev-python/libcst-1[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4[${PYTHON_USEDEP}]
	>=dev-python/sphinx-7[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.10.0[${PYTHON_USEDEP}]
	dev-python/roman[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/tomli-0.10[${PYTHON_USEDEP}]
	' python3_10)
"
