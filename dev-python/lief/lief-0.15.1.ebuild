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
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}/api/python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# The bundled backend declares no build requirements in pyproject.toml; these
# are what api/python/build-requirements.txt actually lists.
BDEPEND="
	dev-build/cmake
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/scikit-build-core[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

# The test suite downloads a large corpus of sample binaries.
RESTRICT="test"

PATCHES=( "${FILESDIR}/${P}-scikit-build-core-targets.patch" )

src_configure() {
	# nanobind's type_caster and tuple templates violate the ODR across
	# translation units, which LTO reports as -Wodr.
	filter-lto

	distutils-r1_src_configure
}

src_prepare() {
	distutils-r1_src_prepare

	# The backend strips the extension itself for release builds, which
	# defeats Portage's own stripping and debug splitting.
	sed -i -e 's|return str(self._config.build.build_type.lower() == "release")|return "false"|' \
		backend/config.py || die
	grep -q 'return "false"' backend/config.py ||
		die "failed to disable the backend's own stripping"

	# A Release build makes both the backend and nanobind strip the extension
	# themselves, which loses the symbols Portage wants to split out.
	sed -i -e 's|^type          = "Release"$|type          = "RelWithDebInfo"|' \
		config-default.toml || die
	grep -q '"RelWithDebInfo"' config-default.toml ||
		die "failed to change the build type"

	# LIEF uses the fixed-width integer types in headers that do not include
	# <cstdint>, which GCC 16 no longer provides transitively.
	local f
	while IFS= read -r -d '' f; do
		grep -q '#include <cstdint>' "${f}" && continue
		grep -qE '\b(u?int(8|16|32|64|ptr)_t)\b' "${f}" || continue
		# Some of these headers only use quoted includes, so match any.
		sed -i -e '0,/^#include /s//#include <cstdint>\n#include /' "${f}" || die
		grep -q '#include <cstdint>' "${f}" ||
			die "failed to add <cstdint> to ${f}"
	done < <(find "${WORKDIR}/${MY_PN}-${PV}/include" \
		"${WORKDIR}/${MY_PN}-${PV}/src" -type f \
		\( -name '*.hpp' -o -name '*.h' -o -name '*.cpp' \) -print0)
}
