# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream has been dormant since 2024 and its only release targets Ghidra 11.2.
# That source no longer compiles against Ghidra 12.x, which replaced the
# Loader.load() parameter list with an ImporterSettings record. This archive was
# produced out of tree from the v${PV} tag with
# files/s3eloader-${PV}-ghidra12-importer-settings.patch applied and
# GHIDRA_INSTALL_DIR pointing at Ghidra ${GHIDRA_PV}:
#
#   patch -p1 <files/s3eloader-${PV}-ghidra12-importer-settings.patch
#   gradle buildExtension
#
# and uploaded to the __distfiles__ release. The patch is kept here so the
# archive can be reproduced; it is not applied at build time. The archive does
# not need rebuilding for every Ghidra release: ghidra-extension.eclass
# retargets it at the installed Ghidra and verifies that it still links against
# it. It will need redoing whenever that check starts failing, which is what
# the ImporterSettings change below did to the 11.2 build.
GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="S3ELoader"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for Marmalade S3E binaries."
HOMEPAGE="https://github.com/knot126/S3ELoader"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-ghidra-${GHIDRA_PV}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

LICENSE="MIT"
KEYWORDS="~amd64"
