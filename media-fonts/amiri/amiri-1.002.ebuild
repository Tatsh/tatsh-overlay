# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="High quality Arabic Naskh-style font"
HOMEPAGE="http://www.amirifont.org/"
DISTNAME_PN="Amiri"
SRC_URI="https://github.com/alif-type/${PN}/releases/download/${PV}/${DISTNAME_PN}-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"

S="${WORKDIR}/${DISTNAME_PN}-${PV}"
