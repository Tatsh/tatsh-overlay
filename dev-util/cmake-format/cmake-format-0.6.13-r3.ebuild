# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_SETUPTOOLS=rdepend
# DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1

DESCRIPTION="Source code formatter for CMake files."
HOMEPAGE="https://github.com/cheshirekow/cmake_format"
SRC_URI="https://github.com/cheshirekow/cmake_format/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN/-/_}-${PV}"

src_prepare() {
	rm setup.py || die
	cp cmakelang/pypi/setup.py . || die
	default
}
