# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Compile and execute C 'scripts' in one go."
HOMEPAGE="https://github.com/ryanmjacobs/c"
SRC_URI="https://github.com/ryanmjacobs/c/archive/v0.10.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/bin
	doexe c

	dodoc README.md

	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples
	fi
}
