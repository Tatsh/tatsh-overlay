# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="RecoverJumpTable"
GHIDRA_EXT_SCRIPTS=( RecoverJumpTable.java )

inherit ghidra-extension

MY_COMMIT="48636f4e4029939889de569f1919b0b99a8d9fcb"

DESCRIPTION="Ghidra script that recovers switch statement jump tables."
HOMEPAGE="https://github.com/Narmjep/RecoverJumpTable"
# Upstream has tagged no releases, so a snapshot is used.
SRC_URI="https://github.com/Narmjep/${GHIDRA_EXT_NAME}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64"
