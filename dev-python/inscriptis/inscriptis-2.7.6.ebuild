# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="HTML to text converter"
HOMEPAGE="https://github.com/weblyzard/inscriptis https://pypi.org/project/inscriptis/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/lxml-5.4.0[${PYTHON_USEDEP}]
	<dev-python/lxml-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.3[${PYTHON_USEDEP}]"

EPYTEST_IGNORE=(
	# Needs the optional FastAPI web service.
	tests/test_web_service.py
)

src_prepare() {
	sed -e '/^addopts = "--cov/d' -i pyproject.toml || die
	distutils-r1_src_prepare
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
