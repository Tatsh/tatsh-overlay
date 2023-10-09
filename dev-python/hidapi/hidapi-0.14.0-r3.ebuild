# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )
inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for hidapi."
HOMEPAGE="https://github.com/trezor/cython-hidapi"

LICENSE="|| ( BSD GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND="
	<dev-python/cython-3[${PYTHON_USEDEP}]
	dev-libs/hidapi
	test? ( dev-python/pytest )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/cython-${P}"

distutils_enable_tests pytest

python_configure_all() {
	DISTUTILS_ARGS=( --with-system-hidapi )
}

python_test() {
	epytest tests.py
}
