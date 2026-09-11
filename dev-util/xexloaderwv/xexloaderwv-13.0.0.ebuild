# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="XEXLoaderWV"

inherit ghidra-extension

# Upstream tags a release per Ghidra version and versions the loader itself
# separately, in extension.properties. This is the tag holding ${PV}.
MY_TAG="12.1.2"

DESCRIPTION="Ghidra loader for Xbox 360 XEX executables."
HOMEPAGE="https://github.com/zerokilo/xexloaderwv"
SRC_URI="https://github.com/zerokilo/${PN}/archive/refs/tags/${MY_TAG}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_TAG}/${GHIDRA_EXT_NAME}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
