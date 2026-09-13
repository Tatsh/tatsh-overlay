# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="VxdTools"
GHIDRA_EXT_SCRIPTS=( ImportSymbolMap.py VxdCall.py )

inherit ghidra-extension

MY_PN="ghidra-vxd-tools"
MY_COMMIT="adc2acaae1a29c9e7b087419638ba3d396f2a332"

DESCRIPTION="Ghidra scripts for reverse engineering Windows 9x virtual device drivers."
HOMEPAGE="https://github.com/andrew-hoffman/ghidra-vxd-tools"
# Upstream has tagged no releases, so a snapshot is used.
SRC_URI="https://github.com/andrew-hoffman/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
