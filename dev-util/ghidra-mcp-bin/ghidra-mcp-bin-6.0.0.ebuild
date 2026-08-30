# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="GhidraMCP"
MY_PN="${PN%-bin}"

inherit ghidra-extension

DESCRIPTION="Ghidra extension exposing program data over MCP for AI-assisted analysis."
HOMEPAGE="https://github.com/bethington/ghidra-mcp"
SRC_URI="https://github.com/bethington/${MY_PN}/releases/download/v${PV}/${GHIDRA_EXT_NAME}-${PV}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

pkg_postinst() {
	elog "The extension runs an embedded HTTP server inside Ghidra. To drive it"
	elog "from an MCP client you also need upstream's separate Python bridge,"
	elog "ghidra_mcp_bridge, which is not packaged here."
}
