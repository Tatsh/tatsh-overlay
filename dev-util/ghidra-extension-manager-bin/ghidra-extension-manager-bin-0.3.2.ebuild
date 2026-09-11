# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream builds the same tree once per supported Ghidra release, so the
# seventeen assets of a tag differ only in the version= property, which
# ghidra-extension.eclass rewrites to the installed Ghidra anyway. The 12.1.3
# asset is used because it is the newest of the 12.1 series the eclass allows.
GHIDRA_PV="12.1.3"
GHIDRA_EXT_NAME="GhidraExtensionManager"

inherit ghidra-extension

# Upstream stamps the build date, not the tag, into the asset name.
MY_DATE="20260828"

DESCRIPTION="Ghidra extension that installs and updates other Ghidra extensions."
HOMEPAGE="https://github.com/antoniovazquezblanco/GhidraExtensionManager"
SRC_URI="https://github.com/antoniovazquezblanco/${GHIDRA_EXT_NAME}/releases/download/v${PV}/ghidra_${GHIDRA_PV}_PUBLIC_${MY_DATE}_${GHIDRA_EXT_NAME}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# Upstream ships no licence file and states no terms anywhere in the
# repository. The bundled jars are Apache-2.0 (commons-io, commons-lang3,
# jackson-*) except github-api, which is MIT.
LICENSE="all-rights-reserved Apache-2.0 MIT"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

pkg_postinst() {
	elog "Ghidra installs extensions into the user settings directory, not into"
	elog "the installation, so anything this extension installs or updates -"
	elog "including itself - lands in ~/.config/ghidra and takes precedence over"
	elog "packages from this overlay. Ghidra then reports a duplicate extension."
	elog "Decline the self-update prompt to keep using this package."
}
