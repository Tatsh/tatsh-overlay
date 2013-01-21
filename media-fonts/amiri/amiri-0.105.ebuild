# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit font

DESCRIPTION="High quality Arabic Naskh-style font"
HOMEPAGE="http://www.amirifont.org/"
SRC_URI="http://files.tatsh.net/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
DOCS="documentation/NEWS-Arabic.txt documentation/README-Arabic.txt"
