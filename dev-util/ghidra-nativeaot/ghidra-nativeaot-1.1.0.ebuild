# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-nativeaot"

inherit ghidra-extension

DESCRIPTION="Ghidra extension for .NET Native AOT compiled binaries."
HOMEPAGE="https://github.com/Washi1337/ghidra-nativeaot"
SRC_URI="https://github.com/Washi1337/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

# MIT is upstream's own. Two sources carry Ghidra's Apache-2.0 skeleton header.
LICENSE="MIT Apache-2.0"
KEYWORDS="~amd64"
