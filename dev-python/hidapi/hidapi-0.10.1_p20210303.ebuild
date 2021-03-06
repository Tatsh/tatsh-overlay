# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="Python wrapper for hidapi."
HOMEPAGE="https://github.com/trezor/cython-hidapi"
MY_SHA="b94c8a09582681aff6edd145a3bfd3948ff7e5ca"
SRC_URI="https://github.com/trezor/cython-${PN}/archive/${MY_SHA}.tar.gz -> cython-${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DEPEND=">=dev-libs/hidapi-${PV%_*}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/cython-${PN}-${MY_SHA}"

python_configure_all() {
	mydistutilsargs=( --with-system-hidapi )
}
