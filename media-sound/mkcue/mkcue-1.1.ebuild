# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI=3
SRC_URI="http://abcde.googlecode.com/svn/mkcue/source/mkcue_1.orig.tar.gz"
DESCRIPTION="Get the table of contents (TOC) from a CD in CUE file format."
HOMEPAGE="http://code.google.com/p/abcde/"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch ${FILESDIR}/mkcue_1-1.diff.gz || die "epatch failed"
}

src_configure() {
	cd "${WORKDIR}/mkcue-1.orig"
	econf || die "econf failed"
}

src_compile() {
	cd "${WORKDIR}/mkcue-1.orig"
	emake -f GNUmakefile || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/mkcue-1.orig"
	mkdir -p ${D}/usr/bin
	emake -f GNUmakefile DESTDIR="${D}" install || die "emake install failed"
}
