# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{2,3} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Simple home directory versioning."
HOMEPAGE="https://github.com/Tatsh/baldwin"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-python/gitpython
	dev-python/binaryornot
	dev-python/click
	dev-python/platformdirs"
