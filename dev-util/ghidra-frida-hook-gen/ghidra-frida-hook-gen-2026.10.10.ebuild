# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-frida-hook-gen"

inherit ghidra-extension

DESCRIPTION="Ghidra extension generating Frida hook snippets for functions."
HOMEPAGE="https://github.com/CENSUS/ghidra-frida-hook-gen"
SRC_URI="https://github.com/CENSUS/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="BSD-2"
KEYWORDS="~amd64"

src_prepare() {
	ghidra-extension_src_prepare

	# Nine prebuilt archives of past releases, committed to the repository.
	rm -r dist || die

	# Upstream excludes this from its own builds so that it does not appear in
	# every user's Script Manager.
	rm ghidra_scripts/RunFridaHookGeneratorSelfTest.java || die
}
