# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-lx-loader"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for Linear Executable (LX, LE, NE) binaries."
HOMEPAGE="https://github.com/yetmorecode/ghidra-lx-loader"
SRC_URI="https://github.com/yetmorecode/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

# lib/file-formats.jar is vendored by the same author with no licence header of
# its own, so it is covered by the repository's licence.
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
