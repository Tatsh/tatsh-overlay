# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils subversion

ESVN_REPO_URI="http://jsdoc-toolkit.googlecode.com/svn/trunk"
DESCRIPTION="A documentation generator for JavaScript."
HOMEPAGE="http://code.google.com/p/jsdoc-toolkit/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
  virtual/jdk"

src_install() {
	insinto /usr/share
	doins -r jsdoc-toolkit

	insinto /usr/bin
	doins "${FILESDIR}"/jsdoc
	fperms a+x /usr/bin/jsdoc
}

pkg_postinst() {
	elog
	elog "Templates are located at: /usr/share/jsdoc-toolkit/templates"
	elog "Example usage: jsdoc -t /usr/share/jsdoc-toolkit/templates"
	elog
}
