# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for the PlayStation 2 homebrew development environment"
HOMEPAGE="https://github.com/ps2dev/ps2dev"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-embedded/gskit
	dev-embedded/masp
	dev-embedded/openvcl
	dev-embedded/ps2-dvp-binutils
	dev-embedded/ps2-ee-binutils
	dev-embedded/ps2-ee-gcc
	dev-embedded/ps2-iop-binutils
	dev-embedded/ps2-iop-gcc
	dev-embedded/ps2-packer
	dev-embedded/ps2client
	dev-embedded/ps2sdk
"
