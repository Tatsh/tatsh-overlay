# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-retro-machines"
GHIDRA_PV_MIN=12.2
GHIDRA_PV_MAX=12.3

inherit java-utils-2 ghidra-extension

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="da7aebc7b6b3c54b388b40253b15f84670d4b088"

DESCRIPTION="Ghidra processor modules and loaders for retro home computers"
HOMEPAGE="https://github.com/CBongo/ghidra-retro-machines"
SRC_URI="https://github.com/CBongo/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND+=" dev-java/snakeyaml:0"
DEPEND="${RDEPEND}"

src_prepare() {
	ghidra-extension_src_prepare
	mkdir -p lib || die
	java-pkg_jar-from --into lib snakeyaml
}
