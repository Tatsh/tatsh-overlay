# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2 eutils

DESCRIPTION="Google's reCAPTCHA library re-written for PHP 5."
HOMEPAGE="https://github.com/Tatsh/recaptcha5"
EGIT_REPO_URI="git://github.com/Tatsh/recaptcha5.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/php-5.3.10"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir recaptcha
	mv *.php recaptcha
}

src_install() {
	insinto /usr/share/php
	doins -r recaptcha

	dodoc README.md
}
