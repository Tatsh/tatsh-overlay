# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils subversion toolchain-funcs

ESVN_REPO_URI="http://okcupid-pidgin.googlecode.com/svn/trunk/"
DESCRIPTION="An OkCupid plugin for Pidgin."
HOMEPAGE="http://code.google.com/p/okcupid-pidgin/"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/pidgin
        dev-libs/json-glib"
RDEPEND="${DEPEND}"

src_prepare() {
	local cc=`tc-getCC`
	cd "${S}"

	if use amd64; then
		sed -i s/LINUX64_COMPILER\ =\.*$/LINUX64_COMPILER\ =\ ${cc}/ Makefile
		sed -i s/all\:.*$/all\:\ libokcupid64.so/ Makefile
	elif use x86; then
		sed -i s/LINUX32_COMPILER\ =\.*$/LINUX32_COMPILER\ =\ ${cc}/ Makefile
		sed -i s/all\:.*$/all\:\ libokcupid.so/ Makefile
	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/purple-2
	if use amd64; then
		doexe libokcupid64.so
	elif use x86; then
		doexe libokcupid.so
	fi
}
