# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Cython hash table that trusts the keys are pre-hashed"
HOMEPAGE="https://github.com/explosion/preshed"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/cymem-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/cymem-2.0.2[${PYTHON_USEDEP}]
	<dev-python/murmurhash-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/murmurhash-0.28.0[${PYTHON_USEDEP}]"

src_test() {
	# Run the installed tests: they use relative imports into the built extensions.
	rm -r "${PN}" || die
	local EPYTEST_FLAGS="--pyargs ${PN}"
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
