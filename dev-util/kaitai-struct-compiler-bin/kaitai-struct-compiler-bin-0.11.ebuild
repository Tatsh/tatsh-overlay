# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-utils-2

MY_PN="${PN%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Compiler that generates binary format parsers from Kaitai Struct definitions"
HOMEPAGE="https://kaitai.io https://github.com/kaitai-io/kaitai_struct_compiler"
SRC_URI="https://github.com/kaitai-io/kaitai_struct_compiler/releases/download/${PV}/${MY_P}.zip"
S="${WORKDIR}/${MY_P}"

# Compiler GPL-3+, bundled Scala library Apache-2.0, scopt MIT, fastparse/sourcecode/geny MIT,
# SnakeYAML Apache-2.0, format definitions under their individual licences.
LICENSE="GPL-3+ Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.8:*"
BDEPEND="app-arch/unzip"

src_install() {
	java-pkg_dojar lib/*.jar
	java-pkg_dolauncher "${MY_PN}" --main io.kaitai.struct.JavaMain
	dosym "${MY_PN}" /usr/bin/ksc
	insinto "/usr/share/${MY_PN}"
	doins -r formats
}
