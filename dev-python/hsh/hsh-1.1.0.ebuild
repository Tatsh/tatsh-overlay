# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1

DESCRIPTION="Hashing library."
HOMEPAGE="https://pypi.org/project/hsh/"
SRC_URI="https://github.com/chrissimpkins/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/commandlines[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_cond_dep 'dev-python/nose') )"

python_test() {
	nosetests --where=tests --verbosity=2 || die
}
