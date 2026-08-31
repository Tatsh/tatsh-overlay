# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream tags every release after the Ghidra version it was built against;
# ${PV} is the plugin version recorded in extension.properties. Ghidra compares
# that property against its own version, so upstream's archive never matched
# any Ghidra release; ghidra-extension.eclass rewrites it.
GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="XEXLoaderWV"
MY_PN="${PN%-bin}"

inherit ghidra-extension

MY_DATE="20260802"

DESCRIPTION="Ghidra loader for Xbox 360 XEX executables."
HOMEPAGE="https://github.com/zerokilo/xexloaderwv"
SRC_URI="https://github.com/zerokilo/${MY_PN}/releases/download/${GHIDRA_PV}/ghidra_${GHIDRA_PV}_PUBLIC_${MY_DATE}_${GHIDRA_EXT_NAME}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
