# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Hangouts plugin for Pidgin."
HOMEPAGE="https://bitbucket.org/EionRobb/purple-hangouts"
SRC_URI="https://bitbucket.org/EionRobb/purple-hangouts/get/0d5539db7391.zip -> ${PN}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-im/pidgin"
DEPEND="${RDEPEND}
	dev-libs/json-glib
	dev-libs/protobuf-c
	virtual/pkgconfig"

S="${WORKDIR}/EionRobb-purple-hangouts-0d5539db7391"

src_prepare() {
	eapply_user
	sed -e "75s/-g -ggdb/${CFLAGS} ${LDFLAGS}/" -i Makefile
}

src_install() {
	outdir=$(pkg-config --variable=plugindir purple)
	insinto "$outdir"
	doins libhangouts.so
	fperms 0755 "${outdir}/libhangouts.so"

	dodoc README.md

	for size in 16 22 24 48; do
		insinto /usr/share/pixmaps/pidgin/protocols/$size
		newins "hangouts${size}.png" 'hangouts.png'
	done
}
