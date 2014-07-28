# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Simple phar creation for every PHP project managed via Composer"
HOMEPAGE="https://github.com/clue/phar-composer"
SRC_URI="https://github.com/clue/phar-composer/releases/download/v0.5.0/phar-composer.phar -> phar-composer-0.5.0.phar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=dev-lang/php-5.3"
DEPEND="${RDEPEND}"

S="$WORKDIR"

src_unpack () {
	einfo 'No unpacking required'
}

src_install () {
	exeinto /usr/bin
	newexe "${DISTDIR}/phar-composer-0.5.0.phar" phar-composer
}
