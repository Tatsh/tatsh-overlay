# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Recursive-descent parser generators for C."
HOMEPAGE="http://piumarta.com/software/peg/"
SRC_URI="http://piumarta.com/software/${PN}/${PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i Makefile -e 's/\tstrip.*$//'
}

src_compile() {
	emake CFLAGS="$CFLAGS" OFLAGS=""
}

src_install() {
	mkdir -p "${D}/usr/bin"
	emake PREFIX="${D}/usr" install
}

# kate: replace-tabs false;
