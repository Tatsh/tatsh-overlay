# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 eutils

DESCRIPTION="Spec for 'standard markdown', with matching C and javascript implementations."
HOMEPAGE="https://github.com/jgm/CommonMark"
EGIT_REPO_URI="git://github.com/jgm/CommonMark.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/re2c-0.13.5-r1"
RDEPEND="${DEPEND}"

src_prepare() {
	# https://github.com/jgm/CommonMark/issues/179
	epatch "${FILESDIR}"/fpic-command-line.patch || die "Check ${HOMEPAGE} to see if anything major has changed"
}

src_compile() {
	emake CFLAGS="$CFLAGS -Wall -Wextra -std=c99 -Isrc -Wno-missing-field-initializers -fPIC" LDFLAGS="$LDFLAGS -Wall -Werror"
}

src_install() {
	dodoc LICENSE README.md
	exeinto /usr/bin
	doexe cmark
}

src_test () {
	emake -j1 spec
}
