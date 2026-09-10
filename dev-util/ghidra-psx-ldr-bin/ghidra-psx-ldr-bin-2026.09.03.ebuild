# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream exports the same tree once per supported Ghidra point release, so
# the eight assets of a tag differ only in the version= property, which
# ghidra-extension.eclass rewrites to the installed Ghidra anyway. The 12.1.3
# asset is used because it is the newest of the 12.1 series the eclass allows.
GHIDRA_PV="12.1.3"
GHIDRA_EXT_NAME="ghidra_psx_ldr"

inherit ghidra-extension

# Upstream stamps the export date, not the tag, into the asset name.
MY_DATE="${PV//./}"

DESCRIPTION="Ghidra loader for Sony PlayStation (PSX) executables."
HOMEPAGE="https://github.com/lab313ru/ghidra_psx_ldr"
SRC_URI="https://github.com/lab313ru/${GHIDRA_EXT_NAME}/releases/download/${PV}/ghidra_${GHIDRA_PV}_PUBLIC_${MY_DATE}_${GHIDRA_EXT_NAME}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# The repository ships no licence file, but every source file carries an
# Apache-2.0 header. The bundled com.udojava.evalex (EvalEx) is MIT.
LICENSE="Apache-2.0 MIT"
KEYWORDS="~amd64"
