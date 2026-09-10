# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream's 1.3.1 release only ships an archive built against Ghidra 12.1.
# This archive was produced out of tree from the 1.3.1 tag with
# files/ghidra-gamecube-loader-1.3.1-loadspec-hijack.patch applied and
# GHIDRA_INSTALL_DIR pointing at Ghidra ${GHIDRA_PV}:
#
#   patch -p1 <files/ghidra-gamecube-loader-1.3.1-loadspec-hijack.patch
#   gradle buildExtension
#
# and uploaded to the __distfiles__ release. The build pulls org.lz4:lz4-java
# from Maven Central, which is why it cannot run inside Portage. The patch is
# kept here so the archive can be reproduced; it is not applied at build time.
#
# Without it this loader claims *every* file Ghidra opens: binaryType is
# initialised to UNKNOWN and so is never null, which made the "binaryType !=
# null" guard always add a preferred load spec; loadProgramInto() then threw a
# LoadException. That shadowed the correct loader for unrelated formats. Ghidra
# reuses one Loader instance for every probe, so the patch also resets the field
# on entry. Upstream still has both bugs on master and has no newer release.
#
# The archive does not need redoing for every Ghidra release:
# ghidra-extension.eclass retargets it at the installed Ghidra and verifies that
# it still links against it.
GHIDRA_PV="12.1.3"
GHIDRA_EXT_NAME="GameCubeLoader"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for Nintendo GameCube binaries."
HOMEPAGE="https://github.com/Cuyler36/Ghidra-GameCube-Loader"
# PF rather than P: each revision ships a differently patched archive, so the
# distfile name has to change along with it.
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${PF}-ghidra-${GHIDRA_PV}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# Apache-2.0 covers both the loader and the bundled lz4-java.
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
