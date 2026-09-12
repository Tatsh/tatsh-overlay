# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GhidraBoy"

inherit ghidra-extension

DESCRIPTION="Ghidra support for the Sharp SM83 processor and Game Boy ROMs."
HOMEPAGE="https://github.com/Gekkio/GhidraBoy"
SRC_URI="https://github.com/Gekkio/${GHIDRA_EXT_NAME}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${P}-ghidra-12.patch" )

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
}
