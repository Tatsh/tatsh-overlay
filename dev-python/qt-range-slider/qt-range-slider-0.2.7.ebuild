# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9,10} )
inherit distutils-r1

DESCRIPTION="Qt widget-slider with two thumbs (min/max values)."
HOMEPAGE="https://pypi.org/project/qt-range-slider/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="$(python_gen_cond_dep 'dev-python/PyQt5[${PYTHON_USEDEP}]')"

distutils_enable_tests pytest

src_prepare() {
	sed -re "s/packages=setuptools\.find_packages[^,]+/packages=['${PN//-/_}']/" -i setup.py || die
	default
}
