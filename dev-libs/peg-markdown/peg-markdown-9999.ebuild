# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 eutils

DESCRIPTION="C library for parsing Markdown."
HOMEPAGE="https://github.com/Tatsh/peg-markdown"
EGIT_REPO_URI="git://github.com/Tatsh/peg-markdown.git"

LICENSE="GPL MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/peg-0.1.9
dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="$CFLAGS"
}

src_install() {
	dodoc LICENSE
	emake DESTDIR="${D}/usr" install
}

# kate: replace-tabs false;
