# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="Fast serialization and validation library."
HOMEPAGE="https://pypi.org/project/msgspec/"
SRC_URI="https://github.com/jcrist/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]"
EPYTEST_IGNORE=( "tests/test_cpylint.py" )

distutils_enable_tests pytest

BDEPEND+="
	test? (
		dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
	)
"

python_test() {
	rm -rf "${PN}" || die
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -m 'not mypy and not pyright'
}


