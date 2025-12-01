# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Brcrypt hashing for Flask."
HOMEPAGE="https://github.com/maxcountryman/flask-bcrypt https://pypi.org/project/flask-bcrypt/"
SRC_URI="$(pypi_sdist_url --no-normalize Flask-Bcrypt)"

S="${WORKDIR}/Flask-Bcrypt-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/bcrypt-3.1.1[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
