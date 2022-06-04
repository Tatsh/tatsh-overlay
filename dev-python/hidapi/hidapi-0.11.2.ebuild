# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9,10} )
inherit distutils-r1

DESCRIPTION="Python wrapper for hidapi."
HOMEPAGE="https://github.com/trezor/cython-hidapi"
MY_PV=$(ver_rs 3 .post)
SRC_URI="https://github.com/trezor/cython-hidapi/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND=">=dev-libs/hidapi-$(ver_cut 1-2)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/cython-${PN}-${MY_PV}"

python_configure_all() {
	mydistutilsargs=( --with-system-hidapi )
}
