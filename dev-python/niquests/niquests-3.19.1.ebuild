# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Simple, yet elegant, HTTP library. Drop-in replacement for Requests."
HOMEPAGE="
	https://github.com/jawah/niquests
	https://pypi.org/project/niquests/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/charset-normalizer-2[${PYTHON_USEDEP}]
	<dev-python/charset-normalizer-4[${PYTHON_USEDEP}]
	>=dev-python/kiss-headers-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-future-2.13.903[${PYTHON_USEDEP}]
	<dev-python/urllib3-future-3[${PYTHON_USEDEP}]
	>=dev-python/wassima-1.0.1[${PYTHON_USEDEP}]
	<dev-python/wassima-3[${PYTHON_USEDEP}]"

src_prepare() {
	rm -r src/niquests/_vendor/kiss_headers || die
	find src/niquests -name '*.py' -exec \
		sed -i 's/from \._vendor\.kiss_headers/from kiss_headers/' {} + || die
	find src/niquests -name '*.py' -exec \
		sed -i 's/from \.\._vendor\.kiss_headers/from kiss_headers/' {} + || die
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
