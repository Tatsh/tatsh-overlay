# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
inherit distutils-r1

DESCRIPTION="Python wrapper for hidapi."
HOMEPAGE="https://github.com/trezor/cython-hidapi"
SRC_URI="https://github.com/trezor/cython-${PN}/archive/${PV}.tar.gz -> cython-${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/hidapi-${PV}"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/cython-${P}"

python_configure_all() {
	mydistutilsargs=( --with-system-hidapi )
}
