# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Humane API for storing and accessing persistent data in IDA Pro databases."
HOMEPAGE="https://pypi.org/project/ida-netnode/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="dev-python/six"

S="${WORKDIR}/${P}"
