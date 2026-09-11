# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GhidraOrbis"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for PlayStation 4 Orbis OS executables."
HOMEPAGE="https://github.com/astrelsky/GhidraOrbis"
SRC_URI="https://github.com/astrelsky/${GHIDRA_EXT_NAME}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${P}-ghidra12-exporter.patch" )

src_prepare() {
	eapply "${PATCHES[@]}"
	ghidra-extension_src_prepare
}
