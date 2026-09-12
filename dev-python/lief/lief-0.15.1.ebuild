# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 flag-o-matic

MY_PN="LIEF"

DESCRIPTION="Library to instrument ELF, PE and Mach-O executable formats."
HOMEPAGE="https://lief.re https://github.com/lief-project/LIEF"
# There is no sdist on PyPI for this series, only wheels. The source tree
# bundles every third party dependency under third-party/ as a zip, including
# nanobind, so nothing is fetched at build time.
SRC_URI="https://github.com/lief-project/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}/api/python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# The bundled backend declares no build requirements in pyproject.toml; these
# are what api/python/build-requirements.txt actually lists. tomli is only
# needed where tomllib is not yet in the standard library.
# shellcheck disable=SC2016
BDEPEND="
	$(python_gen_cond_dep 'dev-python/tomli[${PYTHON_USEDEP}]' python3_10)
	dev-build/cmake
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/scikit-build-core[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

# The test suite downloads a large corpus of sample binaries.
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${P}-scikit-build-core-targets.patch"
	"${FILESDIR}/${P}-no-self-strip.patch"
)

src_configure() {
	# nanobind's type_caster and tuple templates violate the ODR across
	# translation units, which LTO reports as -Wodr.
	filter-lto

	# LIEF uses the fixed-width integer types in 321 headers and sources that
	# never include <cstdint>, relying on it arriving transitively. GCC 16 no
	# longer provides it that way. Forcing it in is one flag rather than a
	# patch touching a third of the tree.
	append-cxxflags -include cstdint

	distutils-r1_src_configure
}
