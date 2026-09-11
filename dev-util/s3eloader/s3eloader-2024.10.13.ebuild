# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="S3ELoader"

inherit ghidra-extension

DESCRIPTION="Ghidra loader for Marmalade S3E binaries."
HOMEPAGE="https://github.com/knot126/S3ELoader"
SRC_URI="https://github.com/knot126/${GHIDRA_EXT_NAME}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${PV}"

LICENSE="MIT"
KEYWORDS="~amd64"

# Upstream has been dormant since 2024 and its only release targets Ghidra 11.2,
# whose Loader.load() parameter list Ghidra 12 replaced with an ImporterSettings
# record.
PATCHES=( "${FILESDIR}/${P}-ghidra12-importer-settings.patch" )

src_prepare() {
	eapply "${PATCHES[@]}"
	ghidra-extension_src_prepare

	# Committed build output.
	rm -r bin || die
}
