# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION=""
HOMEPAGE="https://github.com/tatsh/cross-pc-mingw32-openssl"
SRC_URI="http://www.openssl.org/source/openssl-0.9.8n.tar.gz"
RESTRICT="mirror"

LICENSE="openssl"
SLOT="0.9.8"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-"${PV}"-crossdev-i686-pc-mingw32.patch
	cp "${FILESDIR}"/mingw32-cross.sh ms
}

src_compile() {
	sh ms/mingw32-cross.sh
}

src_install() {
	dobin libeay32.dll || die "Install libeay32.dll failed"
	dobin libssl32.dll || die "Install libssl32.dll failed"

	insinto /usr/include
	doins -r outinc/openssl

	insinto /usr/lib
	doins -r out/*.a
}
