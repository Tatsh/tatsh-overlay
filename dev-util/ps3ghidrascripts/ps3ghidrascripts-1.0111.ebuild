# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="Ps3GhidraScripts"

inherit ghidra-extension

DESCRIPTION="Ghidra scripts for parsing PlayStation 3 executables."
HOMEPAGE="https://github.com/clienthax/Ps3GhidraScripts"
SRC_URI="https://github.com/clienthax/${GHIDRA_EXT_NAME}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
