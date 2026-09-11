# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GameCubeLoader"

inherit java-utils-2 ghidra-extension

MY_PN="Ghidra-GameCube-Loader"

DESCRIPTION="Ghidra loader for Nintendo GameCube binaries."
HOMEPAGE="https://github.com/Cuyler36/Ghidra-GameCube-Loader"
SRC_URI="https://github.com/Cuyler36/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

# Apache-2.0 covers both the loader and the bundled lz4-java.
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

# Upstream resolves this from Maven Central. Ghidra loads every jar in a
# module's lib/, so the system jar is copied in there, which is also where
# upstream's own archive keeps its copy.
DEPEND+=" dev-java/lz4-java:0"

# Without this the loader claims *every* file Ghidra opens: binaryType is
# initialised to UNKNOWN and so is never null, which made the "binaryType !=
# null" guard always add a preferred load spec; loadProgramInto() then threw a
# LoadException. That shadowed the correct loader for unrelated formats. Ghidra
# reuses one Loader instance for every probe, so the patch also resets the field
# on entry. Upstream still has both bugs on master and has no newer release.
PATCHES=( "${FILESDIR}/${P}-loadspec-hijack.patch" )

src_prepare() {
	eapply "${PATCHES[@]}"
	ghidra-extension_src_prepare

	mkdir -p lib || die
	cp "$(java-pkg_getjar lz4-java lz4-java.jar)" lib/ || die
}
