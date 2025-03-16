# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{2,3} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A high-level cross platform tty library."
HOMEPAGE="https://pypi.org/project/teletype/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
