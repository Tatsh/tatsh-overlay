# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Connect and control a PetSafe Smart Feed and Scoopfree device using the PetSafe API."
HOMEPAGE="https://pypi.org/project/petsafe/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]"
