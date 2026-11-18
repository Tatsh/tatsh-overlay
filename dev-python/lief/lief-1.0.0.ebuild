# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 flag-o-matic toolchain-funcs

MY_PN="LIEF"

DESCRIPTION="Library to instrument ELF, PE and Mach-O executable formats"
HOMEPAGE="https://lief.re https://github.com/lief-project/LIEF"
# There is no sdist on PyPI for this series, only wheels. The source tree
# bundles every third party dependency under third-party/ as a zip, including
# nanobind, so nothing is fetched at build time.
# The test corpus is unversioned upstream (lief-tests.s3.fr-par.scw.cloud/lief_tests.zip,
# fetched by tests/dl_samples.py), so a snapshot is kept on the overlay's distfiles release.
SRC_URI="https://github.com/lief-project/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz
	test? ( https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-tests.zip )"
S="${WORKDIR}/${MY_PN}-${PV}/api/python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# The bundled backend declares no build requirements in pyproject.toml; these
# are what api/python/build-requirements.txt actually lists. backend/config.py
# imports tomli unconditionally, with no fallback to the standard library
# tomllib, so it is needed on every implementation.
BDEPEND="
	dev-build/cmake
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/scikit-build-core[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? ( app-arch/unzip )
"

PATCHES=( "${FILESDIR}/${PN}-no-self-strip.patch" )

src_unpack() {
	unpack "${P}.gh.tar.gz"
	if use test; then
		mkdir "${WORKDIR}/samples" || die
		pushd "${WORKDIR}/samples" > /dev/null || die
		unpack "${P}-tests.zip"
		popd > /dev/null || die
	fi
}

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

EPYTEST_DESELECT=(
	# Executes the rewritten x32 ld.so, which needs a kernel with CONFIG_X86_X32_ABI.
	elf/test_builder.py::test_ld_relocations
)

src_test() {
	# Import the built extension rather than the source-tree lief/.
	rm -r lief || die
	# tests/utils.py requires CC to be an existing path.
	local -x CC
	CC="$(type -P "$(tc-getCC)")" || die
	local -x LIEF_SAMPLES_DIR="${WORKDIR}/samples"
	# The suite lives outside S; make it the rootdir so node IDs are relative to it.
	local tests="${WORKDIR}/${MY_PN}-${PV}/tests"
	local EPYTEST_FLAGS="--rootdir=${tests} ${tests}"
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
