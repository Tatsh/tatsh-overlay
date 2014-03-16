# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="Client for Seals with Clubs poker site"
HOMEPAGE="https://sealswithclubs.eu/pc-client/"
SRC_URI="https://sealswithclubs.eu/pcclient/swc_client-Linux%20v0.2.18%20Ubuntu-12.04-i686.zip
https://sealswithclubs.eu/pcclient/swc_client-Linux%20v0.2.18%20Ubuntu-12.04-x86_64.zip"
RESTRICT="mirror strip"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

x86_bin="swc_client-Linux v0.2.18 Ubuntu-12.04-i686"
amd64_bin="swc_client-Linux v0.2.18 Ubuntu-12.04-x86_64"

S="${WORKDIR}"

src_install() {
	dodoc changelog.txt

	insinto /usr/games/share/swc
	doins -r sounds

	keepdir /var/lib/swc/handhistories
	keepdir /var/lib/swc/lobbychat
	dosym /var/lib/swc/handhistories /usr/games/share/swc/handhistories
	dosym /var/lib/swc/lobbychat /usr/games/share/swc/lobbychat

	exeinto /usr/games/share/swc
	if use amd64; then
		doexe "$amd64_bin"
	else
		doexe "$x86_bin"
	fi

	exeinto /usr/games/bin
	doexe "${FILESDIR}/swc"

	fowners root:games /usr/games/bin/swc
	fowners -R root:games /usr/games/share/swc /var/lib/swc
	fperms 0750 /usr/games/bin/swc
	fperms 0770 /var/lib/swc/handhistories
	fperms 0770 /var/lib/swc/lobbychat
}

pkg_postinst() {
	einfo
	einfo "Known issues:"
	einfo "- Runtime warning: Cannot load library icui18n: (libicui18n.so.48: cannot open shared object file: No such file or directory)"
	einfo "- Log directories are kind of a hack: you must be in the games group to use logging features"
	einfo
}
