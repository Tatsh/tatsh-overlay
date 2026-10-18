# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for the PlayStation 2 homebrew development environment"
HOMEPAGE="https://github.com/ps2dev/ps2dev"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-games/gskit
	dev-games/masp
	dev-games/openvcl
	dev-games/ps2-dvp-binutils
	dev-games/ps2-ee-binutils
	dev-games/ps2-ee-gcc
	dev-games/ps2-iop-binutils
	dev-games/ps2-iop-gcc
	dev-games/ps2-packer
	dev-games/ps2client
	dev-games/ps2sdk
"
