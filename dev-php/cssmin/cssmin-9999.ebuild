# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit subversion

DESCRIPTION="A CSS parser and minifier."
HOMEPAGE="http://code.google.com/p/cssmin/"
ESVN_REPO_URI="http://cssmin.googlecode.com/svn/trunk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/php-5.2.3"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0.1-at-keyframes-ms-opera.patch
	epatch "${FILESDIR}"/${PN}-3.0.1-builder-support-cli.patch
	epatch "${FILESDIR}"/${PN}-3.0.1-no-quotes-moz-keyframes.patch

	einfo "Adding CssUrlPrefixMinifierPlugin"
	cp "${FILESDIR}"/${PN}-3.0.1-CssUrlPrefixMinifierPlugin-issue-30.php \
		source/minifier/plugins || die "Failed to add plugin"
}

src_compile() {
	cd tools
	php build.php || die "Build failed."
}

src_install() {
	cd "${S}"
	insinto /usr/share/php
	doins build/CssMin.php
}
