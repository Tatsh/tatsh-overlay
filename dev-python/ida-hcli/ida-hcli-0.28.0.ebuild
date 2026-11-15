# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1 pypi

DESCRIPTION="Command line interface and library for the IDA Pro plugin ecosystem"
HOMEPAGE="https://github.com/HexRaysSA/ida-hcli https://pypi.org/project/ida-hcli/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	<dev-python/httpx-1[${PYTHON_USEDEP}]
	>=dev-python/idapro-0.0.5[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pip-25.2[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.0[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	>=dev-python/rich-14.1[${PYTHON_USEDEP}]
	dev-python/rich-click[${PYTHON_USEDEP}]
	>=dev-python/semantic-version-2.10.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/truststore-0.10.4[${PYTHON_USEDEP}]
"
