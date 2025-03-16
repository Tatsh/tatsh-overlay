# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Fetch and set configuration values in IDA Pro IDAPython scripts."
HOMEPAGE="https://pypi.org/project/ida-settings/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="dev-python/ida-netnode[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P}"
