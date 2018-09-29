# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Noto font with colour emoji."
HOMEPAGE="https://google.com/get/noto"
SRC_URI="https://noto-website.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="$WORKDIR"

FONT_SUFFIX="ttf"
FONT_S="."
FONT_CONF="${FILESDIR}/99-${PN}.conf"
