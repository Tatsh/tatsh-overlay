# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )
inherit distutils-r1

DESCRIPTION="Fetch and set configuration values in IDA Pro IDAPython scripts"
HOMEPAGE="https://pypi.org/project/ida-settings/"
SRC_URI="https://github.com/williballenthin/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	>=dev-python/ida-hcli-0.14.2[${PYTHON_USEDEP}]
	dev-python/ida-netnode[${PYTHON_USEDEP}]
"
# The legacy API needs a Qt binding (PyQt5 or PySide6) once QtCore is used.
BDEPEND="test? ( dev-python/pyside[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
