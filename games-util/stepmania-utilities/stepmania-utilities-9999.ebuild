# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games git-2

DESCRIPTION="Utilities for managing StepMania/DWI simfiles."
HOMEPAGE="https://github.com/Tatsh/StepMania-Utilities"
EGIT_REPO_URI="git://github.com/Tatsh/StepMania-Utilities.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/games/bin
	doexe dwi-adjust-gap dwi-adjust-bpm
}
