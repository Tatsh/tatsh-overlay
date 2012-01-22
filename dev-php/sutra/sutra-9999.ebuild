# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2 depend.php

EAPI=4

DESCRIPTION="An extension upon Flourish."
HOMEPAGE="http://www.poluza.com/"
EGIT_REPO_URI="git://github.com/tatsh/sutra.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="site"

DEPEND=""
RDEPEND=">=dev-lang/php-5.2.3
				 dev-php/flourish[sutra-patches]
				 dev-php/moor[sutra-patches]"

src_prepare() {
	mkdir sutra
	cp -R classes model routers scripts sutra
	
	mkdir bin
	cp -R "${FILESDIR}"/sutra-jsccd bin
	cp -R "${FILESDIR}"/sutra-jscc bin
	# cp -R "${FILESDIR}"/sutra-install-schema bin
	
	if use site ; then
		mv site htdocs
	fi
}

src_install() {
	dobin bin/sutra-jsccd || die "install sutra-jsccd failed"
	dobin bin/sutra-jscc || die "install sutra-jscc failed"
	
	insinto /usr/share/php
	doins -r sutra
	
	if use site ; then
		insinto /usr/share/webapps/sutra/${PV}
		doins -r htdocs
	fi
	
	einfo "To begin a site, copy /usr/share/webapps/${PV}/htdocs to where your site roots are."
}
