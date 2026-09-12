# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Yaz0 compression and decompression library."
HOMEPAGE="https://github.com/aboood40091/libyaz0 https://pypi.org/project/libyaz0/"
# Upstream publishes the sdist as a zip.
SRC_URI="$(pypi_sdist_url "${PN}" "${PV}" .zip)"
S="${WORKDIR}/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
