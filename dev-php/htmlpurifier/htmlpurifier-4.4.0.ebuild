# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Standards-compliant HTML filter library."
HOMEPAGE="http://htmlpurifier.org/"
SRC_URI="http://htmlpurifier.org/releases/$PN-$PV.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/php/htmlpurifier
	doins -r library/*

	dodoc README NEWS CREDITS TODO VERSION WHATSNEW WYSIWYG

	if use doc ; then
		dohtml -r docs/*
	fi
}
