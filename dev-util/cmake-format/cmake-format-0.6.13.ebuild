# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..9} )
inherit distutils-r1

DESCRIPTION="Source code formatter for CMake files."
HOMEPAGE="https://github.com/cheshirekow/cmake_format"
SRC_URI="https://github.com/cheshirekow/cmake_format/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pyyaml
	dev-python/jinja
	dev-python/six"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN/-/_}-${PV}"
