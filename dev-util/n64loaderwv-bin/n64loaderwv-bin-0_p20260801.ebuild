# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream tags every release after the Ghidra version it was built against and
# carries no version of its own, so this is dated after the release archive.
GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="N64LoaderWV"
MY_PN="${PN%-bin}"

inherit ghidra-extension

MY_DATE="20260801"

DESCRIPTION="Ghidra loader for Nintendo 64 ROMs."
HOMEPAGE="https://github.com/zerokilo/n64loaderwv"
SRC_URI="https://github.com/zerokilo/${MY_PN}/releases/download/${GHIDRA_PV}/ghidra_${GHIDRA_PV}_PUBLIC_${MY_DATE}_${GHIDRA_EXT_NAME}.zip
	-> ${P}.zip"
S="${WORKDIR}/${GHIDRA_EXT_NAME}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
