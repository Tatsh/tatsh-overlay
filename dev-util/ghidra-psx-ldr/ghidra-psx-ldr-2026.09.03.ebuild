# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra_psx_ldr"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for Sony PlayStation (PSX) executables."
HOMEPAGE="https://github.com/lab313ru/ghidra_psx_ldr"
SRC_URI="https://github.com/lab313ru/${GHIDRA_EXT_NAME}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

# The repository ships no licence file, but every source file carries an
# Apache-2.0 header. The vendored com.udojava.evalex (EvalEx) is MIT.
LICENSE="Apache-2.0 MIT"
KEYWORDS="~amd64"
