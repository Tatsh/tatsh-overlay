# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
# The tests need nothing beyond pytest itself.
EPYTEST_PLUGINS=()
# Bounded above by dev-python/pyghidra.
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

# Upstream has never tagged a release and is not on PyPI, so this is a snapshot
# of the default branch at upstream's own version.
MY_COMMIT="a0bc447b3beed83a260b8c2bd38b3da9ad9743bc"

DESCRIPTION="Automates Ghidra analysis of Unity IL2CPP binaries."
HOMEPAGE="https://github.com/TeamRocketIst/il2cpp-ghidrah"
SRC_URI="https://github.com/TeamRocketIst/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pyghidra-3.0.2[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare

	# Upstream asks for pyghidra 3.1, but the only thing it uses from it,
	# HeadlessPyGhidraLauncher, has been there since well before that.
	sed -i 's/"pyghidra>=3.1,<4"/"pyghidra<4"/' pyproject.toml || die
}

pkg_postinst() {
	elog "This drives other tools that are not packaged here. Put Il2CppDumper"
	elog "and Cpp2IL on PATH, and install the TurboHeader Ghidra extension, or"
	elog "the corresponding steps are skipped."
}

distutils_enable_tests pytest
