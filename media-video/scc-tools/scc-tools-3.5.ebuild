# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Scenarist Closed Caption format tools."
HOMEPAGE="http://www.theneitherworld.com/mcpoodle/SCC_TOOLS/DOCS/SCC_TOOLS.HTML"
SRC_URI="http://www.theneitherworld.com/mcpoodle/SCC_TOOLS/SCC_TOOLS.ZIP -> ${P}.zip"
S="${WORKDIR}/SOURCE"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/perl"
BDEPEND="app-text/dos2unix app-arch/unzip"

src_install() {
	local i
	for i in *.pl; do
		dos2unix "$i" || die
		echo '#!/usr/bin/env perl' > new.pl
		cat "$i" >> new.pl
		newbin new.pl "$i"
	done
}
