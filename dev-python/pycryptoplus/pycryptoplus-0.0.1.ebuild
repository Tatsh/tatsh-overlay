# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9,10} )
inherit distutils-r1

DESCRIPTION="Cipher extension (used by games-util/nut)."
HOMEPAGE="https://pypi.org/project/pycryptoplus/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

RDEPEND="$(python_gen_cond_dep 'dev-python/pycryptodome[${PYTHON_USEDEP}]')"
