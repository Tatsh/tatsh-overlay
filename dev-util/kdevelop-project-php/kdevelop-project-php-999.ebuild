# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Installs a KDevelop project file into the PHP libraries directory."
HOMEPAGE="https://github.com/tatsh"
REPO_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=dev-lang/php-5.2.3"
RDEPEND="${DEPEND}"

# [Project]
# Manager=KDevGenericManager
# Name=sutra-lib
# VersionControl=

src_prepare() {
	echo "[Project]" >> php.kdev4
	echo "Manager=KDevGenericManager" >> php.kdev4
	echo "Name=php" >> php.kdev4
	echo "VersionControl=" >> php.kdev4

	mkdir .kdev4
}

src_install() {
	insinto /usr/share/php
	doins php.kdev4
	doins -r .kdev4

	fperms g+w /usr/share/php/php.kdev4
	fperms -R g+w /usr/share/php/.kdev4
}

pkg_postinst() {
	elog
	elog "The installed file and directory must be writable for the user you"
	elog "  run KDevelop as. Example with chgrp:"
	elog
	elog "  chgrp developers /usr/share/php/php.kdev4"
	elog "  chgrp -R developers /usr/share/php/.kdev4"
	elog
}
