	# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils pax-utils

DESCRIPTION="Emulates the sound hardware of vintage consoles and computers, allowing you to listen to completely authentic renditions of classic video game tunes"
HOMEPAGE="http://www.bannister.org/software/ao.htm"
SRC_URI=""

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="pax_kernel"
RESTRICT="strip"

DEPEND="net-misc/curl
x11-libs/wxGTK"
RDEPEND="${DEPEND}"

S="${WORKDIR}/AudioOverloadLinux64"

src_unpack() {
	# evil download method :P
	local suffix=
	if use amd64; then
		suffix=64
	fi
	local uri="http://www.bannister.org/cgi-bin/download.cgi?aolin$suffix"
	local real_uri=$(curl -v -XGET "$uri" 2>&1 | grep '< Location' | sed -r -e 's/< Location\: (http.*\.bz2)/\1/')
	local fn="${WORKDIR}/ao20.tar.bz2"

	curl "${real_uri}" > "${fn}" || die "Could not download from actual URI: ${real_uri}"
	cd "${WORKDIR}"
	tar xvjf "${fn}" || die "Failed to unpack"
}

src_install() {
	cd "${S}"
	exeinto /usr/bin
	doexe ao
	dodoc readme_lnx.txt

	if use pax_kernel; then
		pax-mark Cm "${ED}"/usr/bin/ao || die
		eqawarn "You have set USE=pax_kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel.  To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!  If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi

	# icon extracted using '1-liner' here: http://unix.stackexchange.com/questions/48860/how-to-dump-the-icon-of-a-running-x-program
	# TODO Find a way to do this using just the binary and not xprop. Would be useful as a general utility
	for i in 16 32 64 128; do
		newicon -s "${i}" "${FILESDIR}/ao-${i}.png" ao.png
	done

	make_desktop_entry ao 'Audio Overload'
}

# kate: replace-tabs false;
