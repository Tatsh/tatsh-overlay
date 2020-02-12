# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Slender typeface for code, from code"
HOMEPAGE="https://be5invis.github.io/Iosevka/"
MY_P="${P/beta/beta.}"
MY_P="${MY_P/_/-}"
MY_PV="${PV/beta/beta.}"
MY_PV="${MY_PV/_/-}"
SRC_URI="https://github.com/be5invis/${PN}/releases/download/v${MY_PV}/01-${MY_P}.zip
https://github.com/be5invis/${PN}/releases/download/v${MY_PV}/02-${PN}-term-${MY_PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}
FONT_S="${S}/ttf"
FONT_SUFFIX="ttf"
