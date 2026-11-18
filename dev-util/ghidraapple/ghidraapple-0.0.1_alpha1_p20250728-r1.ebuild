# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GhidraApple"
GHIDRA_EXT_TESTS=junit5
GHIDRA_EXT_TEST_JARS=( json )

inherit ghidra-extension

MY_COMMIT="828847d8e705e1373ac87620adeeef448edecd54"

DESCRIPTION="Better Apple binary analysis for Ghidra"
HOMEPAGE="https://github.com/ReverseApple/GhidraApple"
# The only release, v0.0.1-alpha1, is a prebuilt archive for Ghidra 11.3.1 from
# March 2025. Building the sources against the installed Ghidra is what makes
# this work at all, so the snapshot is used instead.
SRC_URI="https://github.com/ReverseApple/${GHIDRA_EXT_NAME}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_COMMIT}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

# 56 of the module's 57 sources are Kotlin.
BDEPEND+=" dev-lang/kotlin-bin"
DEPEND+=" test? ( dev-java/json:0 )"

PATCHES=( "${FILESDIR}/${PN}-ghidra-12.2.patch"  "${FILESDIR}/${PN}-ghidra-12.patch" )

src_prepare() {
	ghidra-extension_src_prepare

	# ProgramBuilder.createEmptyFunction takes an int body size.
	sed -i -e 's/0x100008c6c - 0x100008c34,/(0x100008c6c - 0x100008c34).toInt(),/' \
		src/test/java/lol/fairplay/ghidraapple/core/typeinference/ObjcAllocationInitializationTest.kt || die
}
