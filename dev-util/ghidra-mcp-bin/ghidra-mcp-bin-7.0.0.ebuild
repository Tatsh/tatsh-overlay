# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Keep the existing package atom while rebuilding the plugin from source.
GHIDRA_EXT_NAME="GhidraMCP"
MY_PN="${PN%-bin}"

inherit ghidra-extension

DESCRIPTION="Ghidra extension exposing program data over MCP for AI-assisted analysis"
HOMEPAGE="https://github.com/bethington/ghidra-mcp"
SRC_URI="https://github.com/bethington/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${PN}-ghidra-12.2.patch" )
IUSE="scripts"

src_prepare() {
	ghidra-extension_src_prepare

	local ghidra_version
	ghidra_version="$(ghidra-extension_get_ghidra_version)" || die
	sed -i -e "s/\${project.version}/${PV}/g" \
		-e "s/\${ghidra.version}/${ghidra_version}/g" \
		-e "s/\${build.timestamp}/${SOURCE_DATE_EPOCH:-0}/g" \
		-e "s/\${build.number}/${PR}/g" \
		src/main/resources/extension.properties \
		src/main/resources/com/xebyte/version.properties || die
	cp src/main/resources/extension.properties . || die
	touch Module.manifest || die
}

src_install() {
	insinto "${GHIDRA_HOME}/Ghidra/Extensions/${GHIDRA_EXT_NAME}"
	doins extension.properties Module.manifest
	doins -r lib
	use scripts && doins -r ghidra_scripts

	# archive/ is superseded material upstream keeps for its own history.
	rm -r docs/archive || die
	dodoc -r docs
}

pkg_postinst() {
	elog "The extension runs an embedded HTTP server inside Ghidra. To drive it"
	elog "from an MCP client you also need upstream's separate Python bridge,"
	elog "which is dev-python/ghidra-mcp-bridge."
}
