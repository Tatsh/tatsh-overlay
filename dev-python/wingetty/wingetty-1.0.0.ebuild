# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit python-r1

DESCRIPTION="WinGet repository server (REST API only)."
HOMEPAGE="https://github.com/thilojaeggi/WinGetty"
SRC_URI="https://github.com/thilojaeggi/WinGetty/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/alembic[${PYTHON_USEDEP}]
	dev-python/dynaconf[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-bcrypt[${PYTHON_USEDEP}]
	dev-python/flask-login[${PYTHON_USEDEP}]
	dev-python/flask-migrate[${PYTHON_USEDEP}]
	dev-python/flask-sqlalchemy[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/WinGetty-${PV}"

src_install() {
	python_moduleinto wingetty
	python_foreach_impl python_domodule app/*
}
