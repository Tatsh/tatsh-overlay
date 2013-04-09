# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 multilib

DESCRIPTION="Allows running privileged network services as a non-privileged user"
HOMEPAGE="http://www.chiark.greenend.org.uk/ucgi/~ian/git/authbind.git/"
EGIT_REPO_URI="git://git.chiark.greenend.org.uk/~ian/authbind.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

MAJOR_VERSION="1.0"
SONAME="1"

# TODO Support Mac build
#   https://github.com/Castaglia/MacOSX-authbind
src_compile() {
	emake prefix=/usr \
		CFLAGS="$CFLAGS" \
		OPTIMIZE="" \
		LDFLAGS="$LDFLAGS" \
		STRIP="$CHOST-strip"
}

src_install() {
	dobin authbind

	local libdir=/usr/$(get_libdir)/authbind

	exeinto $libdir
	doexe helper libauthbind.so.${MAJOR_VERSION}
	dosym $libdir/libauthbind.so.${MAJOR_VERSION} $libdir/libauthbind.so.${SONAME}

	local keep=".keep-${PN}-${PV}"
	echo > .keep-${PN}-${PV}
	insinto /etc/authbind
	doins $keep

	for i in byport byaddress byuid; do
		insinto /etc/authbind/$i
		doins $keep
	done

	doman authbind-helper.8 authbind.1
}

# kate: replace-tabs false;
