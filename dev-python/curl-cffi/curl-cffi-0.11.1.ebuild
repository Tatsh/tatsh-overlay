# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Python binding for curl-impersonate fork via cffi."
HOMEPAGE="https://pypi.org/project/curl-cffi/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	>=net-misc/curl-impersonate-1.0.0"

PATCHES=( "${FILESDIR}/${PN}-0001-system-libs.patch" )

distutils_enable_tests pytest
