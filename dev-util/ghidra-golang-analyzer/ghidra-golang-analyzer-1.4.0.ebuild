# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GolangAnalyzerExtension"

inherit ghidra-extension

MY_PN="Ghidra_GolangAnalyzerExtension"

DESCRIPTION="Ghidra extension recovering function names and types from Go binaries."
HOMEPAGE="https://github.com/mooncat-greenpy/Ghidra_GolangAnalyzerExtension"
SRC_URI="https://github.com/mooncat-greenpy/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
# The module is a subdirectory of the repository.
S="${WORKDIR}/${MY_PN}-${PV}/${GHIDRA_EXT_NAME}"

LICENSE="MIT"
KEYWORDS="~amd64"
