# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="N64LoaderWV"

inherit ghidra-extension

# Upstream tags a release per Ghidra version rather than versioning the loader.
DESCRIPTION="Ghidra loader for Nintendo 64 ROMs."
HOMEPAGE="https://github.com/zerokilo/n64loaderwv"
SRC_URI="https://github.com/zerokilo/${PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
