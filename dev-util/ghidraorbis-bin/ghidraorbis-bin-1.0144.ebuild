# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Newest Ghidra upstream's 1.0144 release ships an archive for; the four assets
# differ only in the version= property, which ghidra-extension.eclass rewrites.
# The bytecode still links against Ghidra 12.1: the extension drops its own
# DefaultElfProgramBuilder into the ghidra.app.util.opinion package to reach
# ElfProgramBuilder, which is package-private, and every member it calls there
# is still present and public.
GHIDRA_PV="12.0.3"
GHIDRA_EXT_NAME="GhidraOrbis"

inherit ghidra-extension

MY_DATE="20260605"

DESCRIPTION="Ghidra loader for PlayStation 4 Orbis OS executables."
HOMEPAGE="https://github.com/astrelsky/GhidraOrbis"
SRC_URI="https://github.com/astrelsky/${GHIDRA_EXT_NAME}/releases/download/${PV}/ghidra_${GHIDRA_PV}_PUBLIC_${MY_DATE}_${GHIDRA_EXT_NAME}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

LICENSE="GPL-3"
KEYWORDS="~amd64"
