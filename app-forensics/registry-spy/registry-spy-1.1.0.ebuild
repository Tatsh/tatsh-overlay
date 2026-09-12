# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 xdg

MY_PN="Registry-Spy"

DESCRIPTION="Cross-platform Windows Registry browser."
HOMEPAGE="https://github.com/andyjsmith/Registry-Spy"
SRC_URI="https://github.com/andyjsmith/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pyside-6.5:6[${PYTHON_USEDEP}]
	>=dev-python/python-registry-1.3.1[${PYTHON_USEDEP}]
"
