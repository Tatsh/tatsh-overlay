# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python HTTP for Humans."
HOMEPAGE="https://github.com/ross/requests-futures"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-python/requests"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"
