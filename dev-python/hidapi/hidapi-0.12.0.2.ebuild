# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8,9,10} )
inherit distutils-r1

DESCRIPTION="Python wrapper for hidapi."
HOMEPAGE="https://github.com/trezor/cython-hidapi"
MY_PV=$(ver_rs 3 .post)
SRC_URI="https://github.com/trezor/cython-hidapi/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-libs/hidapi
	test? ( dev-python/pytest )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/cython-${PN}-${MY_PV}"

distutils_enable_tests pytest

python_configure_all() {
	DISTUTILS_ARGS=( --with-system-hidapi )
}

python_test() {
	epytest tests.py
}
