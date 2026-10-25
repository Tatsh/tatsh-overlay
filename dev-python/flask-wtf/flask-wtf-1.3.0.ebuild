# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Form rendering, validation, and CSRF protection for Flask with WTForms"
HOMEPAGE="https://github.com/pallets-eco/flask-wtf https://pypi.org/project/flask-wtf/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	dev-python/wtforms[${PYTHON_USEDEP}]"

BDEPEND="test? (
		dev-python/flask-babel[${PYTHON_USEDEP}]
	)"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
