# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Allows third-party developers to write applications that utilize the Spotify music streaming service."
HOMEPAGE="https://developer.spotify.com/technologies/libspotify/"
SRC_URI="amd64? ( https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-x86_64-release.tar.gz )
	x86? ( https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-i686-release.tar.gz )
"
# Someday...
#	armv5t? ( https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-armv5-release.tar.gz )
#	armv6t? ( https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-armv6-release.tar.gz )
#	armv7a? ( https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-armv7-release.tar.gz )
RESTRICT="strip"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

DEPEND=""
RDEPEND="${DEPEND}"

arch=x86_64

if use x86; then
	arch=i686
fi

S="${WORKDIR}/libspotify-12.1.51-Linux-${arch}-release"

src_prepare() {
	epatch "${FILESDIR}/${PN}-${PV}-makefile.patch" || die "Patching failed!"
}

src_install() {
	emake prefix="${D}/usr" install

	dohtml licenses.xhtml
	dodoc README LICENSE ChangeLog
	doenvd "${FILESDIR}/99libspotify"

	pushd "${S}/share/man3" >/dev/null
	for i in *; do
		doman "$i"
	done
	popd >/dev/null

	if use doc; then
		insinto /usr/share/libspotify
		doins -r "${S}/share/doc/libspotify/html" "${S}/share/doc/libspotify/images"
	fi

	if use examples; then
		doins -r "${S}/share/doc/libspotify/examples"
	fi
}

# kate: replace-tabs false;
