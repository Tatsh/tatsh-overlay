# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="High-level file-system operations."
HOMEPAGE="https://pypi.org/project/python-fsutil/"
SRC_URI="https://github.com/fabiocaccamo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

distutils_enable_tests pytest
