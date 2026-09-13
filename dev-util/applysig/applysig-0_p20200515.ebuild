# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ApplySig"
GHIDRA_EXT_SCRIPTS=( ApplySig.py )

inherit ghidra-extension

MY_COMMIT="4a40e0e6a321a7f2a32fb5f67c47dc7ff85f39c7"

DESCRIPTION="Ghidra script that applies IDA FLIRT signatures."
HOMEPAGE="https://github.com/NWMonster/ApplySig"
# Upstream has tagged no releases, so a snapshot is used.
SRC_URI="https://github.com/NWMonster/${GHIDRA_EXT_NAME}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_COMMIT}"

LICENSE="LGPL-3"
KEYWORDS="~amd64"
