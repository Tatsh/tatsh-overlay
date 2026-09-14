# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="Ps3GhidraScripts"

inherit ghidra-extension

# Upstream tags builds as "1.0" followed by a build number. Portage compares a component with a
# leading zero as a string, which puts 1.099 above 1.0111, so the version drops that zero and the
# tag is rebuilt from it.
MY_PV="1.0${PV#1.}"

DESCRIPTION="Ghidra scripts for parsing PlayStation 3 executables."
HOMEPAGE="https://github.com/clienthax/Ps3GhidraScripts"
SRC_URI="https://github.com/clienthax/${GHIDRA_EXT_NAME}/archive/refs/tags/${MY_PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_PV}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
