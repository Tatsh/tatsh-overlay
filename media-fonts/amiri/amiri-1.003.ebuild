# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="High quality Arabic Naskh-style font"
HOMEPAGE="https://aliftype.com/amiri/"
DISTNAME_PN="Amiri"
SRC_URI="https://github.com/aliftype/${PN}/releases/download/${PV}/${DISTNAME_PN}-${PV}.zip"
S="${WORKDIR}/${DISTNAME_PN}-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
