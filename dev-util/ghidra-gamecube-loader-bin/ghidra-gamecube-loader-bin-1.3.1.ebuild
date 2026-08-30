# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream's 1.3.1 release only ships an archive built against Ghidra 12.1, and
# an extension archive is only valid for the exact Ghidra version it was built
# against. This archive was therefore produced out of tree from the 1.3.1 tag
# with GHIDRA_INSTALL_DIR pointing at Ghidra ${GHIDRA_PV}:
#
#   gradle buildExtension
#
# and uploaded to the __distfiles__ release. The build pulls org.lz4:lz4-java
# from Maven Central, which is why it cannot run inside Portage.
GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="GameCubeLoader"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for Nintendo GameCube binaries."
HOMEPAGE="https://github.com/Cuyler36/Ghidra-GameCube-Loader"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-ghidra-${GHIDRA_PV}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# Apache-2.0 covers both the loader and the bundled lz4-java.
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
