# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
# Upstream allows 3.10, but dev-python/mcp starts at 3.12.
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN="ghidra-mcp"

DESCRIPTION="MCP bridge exposing Ghidra's reverse engineering tools to MCP clients."
HOMEPAGE="https://github.com/bethington/ghidra-mcp"
SRC_URI="https://github.com/bethington/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${MY_PN}-${PV}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/mcp-2[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.28.1[${PYTHON_USEDEP}]
"

pkg_postinst() {
	elog "The bridge talks to the HTTP server that dev-util/ghidra-mcp-bin"
	elog "runs inside Ghidra, so install that as well and have Ghidra open"
	elog "before starting bridge-mcp-ghidra."
}
