# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PV=${PV/_/-}
MY_P="phpMyAdmin-${MY_PV}-all-languages"

DESCRIPTION="Web-based administration for MySQL database in PHP"
HOMEPAGE="http://www.phpmyadmin.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos"
SLOT="0"
IUSE=""

RDEPEND="
        dev-lang/php[crypt,ctype,filter,json,session,unicode]
        || (
                dev-lang/php[mysqli]
                dev-lang/php[mysql]
        )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

CONFIG_FILE=/etc/phpmyadmin.config.php

src_install() {
	echo '<?php echo "Not configured yet"' >> phpmyadmin.config.php
	insinto /etc
	doins phpmyadmin.config.php

	cd "$S"
	rm -f config.sample.inc.php
	mv LICENSE ChangeLog README RELEASE-DATE-${MY_PV} ..
	cd ..

	insinto /usr/share/phpmyadmin
	dosym "$CONFIG_FILE" config.inc.php
	doins -r "${S}"/*

	dodoc LICENSE ChangeLog README RELEASE-DATE-${MY_PV}
}

pkg_config () {
	if [ -f "${CONFIG_FILE}" ]; then
		return
	fi
}
