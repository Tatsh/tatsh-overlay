# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..15} )

PYPI_VERIFY_REPO="https://github.com/pytest-dev/pytest-env"

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin to set environment variables for tests"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-env
	https://pypi.org/project/pytest-env/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pytest-9.1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.2.4[${PYTHON_USEDEP}]"

src_prepare() {
	# The hook only embeds an SBOM in the wheel and is not packaged.
	sed -i -e '/^build\.hooks\.python-sbom = /d' pyproject.toml || die
	distutils-r1_src_prepare
}

# Tests run pytest in subprocesses, which need the plugins too.
EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" pytest-mock )
distutils_enable_tests pytest
