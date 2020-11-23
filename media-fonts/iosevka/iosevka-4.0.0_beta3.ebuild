# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Slender typeface for code, from code"
HOMEPAGE="https://be5invis.github.io/Iosevka/"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV/beta/beta.}"
SRC_URI="https://github.com/be5invis/${PN}/releases/download/v${MY_PV}/ttf-${PN}-${MY_PV}.zip
https://github.com/be5invis/${PN}/releases/download/v${MY_PV}/ttf-${PN}-fixed-${MY_PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"
