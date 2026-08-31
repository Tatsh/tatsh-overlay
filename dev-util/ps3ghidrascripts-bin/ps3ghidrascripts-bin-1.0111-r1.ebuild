# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Newest Ghidra upstream's 1.0111 release ships an archive for. They differ
# only in the version= property, which ghidra-extension.eclass rewrites anyway.
GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="Ps3GhidraScripts"

inherit ghidra-extension

MY_DATE="20260712"

DESCRIPTION="Ghidra scripts for parsing PlayStation 3 executables."
HOMEPAGE="https://github.com/clienthax/Ps3GhidraScripts"
SRC_URI="https://github.com/clienthax/${GHIDRA_EXT_NAME}/releases/download/${PV}/ghidra_${GHIDRA_PV}_PUBLIC_${MY_DATE}_${GHIDRA_EXT_NAME}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
