# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GhidraBoy"
GHIDRA_EXT_TESTS=junit5
# DecompilerTest uses the IDE-only @Language annotation.
GHIDRA_EXT_TEST_JARS=( jetbrains-annotations )

inherit ghidra-extension

DESCRIPTION="Ghidra support for the Sharp SM83 processor and Game Boy ROMs"
HOMEPAGE="https://github.com/Gekkio/GhidraBoy"
SRC_URI="https://github.com/Gekkio/${GHIDRA_EXT_NAME}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

# The tests are Kotlin.
BDEPEND+=" test? ( dev-lang/kotlin-bin )"
DEPEND+=" test? ( dev-java/jetbrains-annotations:0 )"

PATCHES=( "${FILESDIR}/${PN}-ghidra-12.2.patch"  "${FILESDIR}/${PN}-ghidra-12.patch" )

src_prepare() {
	# Upstream generates extension.properties from build.gradle.kts, which
	# cannot run here. name= and version= are rewritten by the eclass.
	cat > extension.properties <<-EOF || die
		name=${GHIDRA_EXT_NAME}
		description=Support for Sharp SM83 / Game Boy
		author=Gekkio
		createdOn=2025-08-30
		version=0
	EOF

	ghidra-extension_src_prepare

	# These compare against decompiler output from before Ghidra 12.2, which
	# simplifies the same expressions differently.
	local name
	for name in 'upper nibble popcount' sla8_to_16 'DAA decompilation'; do
		sed -i -e "s/^\(\s*\)fun \`${name}\`()/\1@org.junit.jupiter.api.Disabled(\"Ghidra 12.2 output\")\n&/" \
			src/test/kotlin/fi/gekkio/ghidraboy/decompiler/DecompilerTest.kt || die
	done
}
