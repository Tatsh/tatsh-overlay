# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 eutils

DESCRIPTION="Spec for 'standard markdown', with matching C and javascript implementations."
HOMEPAGE="https://github.com/jgm/stmd"
EGIT_REPO_URI="git://github.com/jgm/stmd"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-util/re2c-0.13.5-r1
	doc? ( app-text/pandoc )"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="$CFLAGS -std=c99 -Isrc -Wno-missing-field-initializers" LDFLAGS="$LDFLAGS"
}

src_install() {
	dodoc LICENSE README.md TODO
	exeinto /usr/bin
	doexe stmd
}

src_test () {
	emake -j1 spec
}
