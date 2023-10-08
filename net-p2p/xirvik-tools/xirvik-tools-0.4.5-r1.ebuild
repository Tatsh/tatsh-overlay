# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Tools for Xirvik servers."
HOMEPAGE="https://github.com/Tatsh/xirvik-tools"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest

src_install() {
	doman man/xirvik.1
	distutils-r1_src_install
}
