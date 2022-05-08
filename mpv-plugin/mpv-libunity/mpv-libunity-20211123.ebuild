# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="cplugins,libmpv"
inherit mpv-plugin toolchain-funcs

DESCRIPTION="Shows progress on a panel following libunity specification."
HOMEPAGE="https://github.com/mrlotfi/mpv-libunity"
SHA="e111b49e7d4ace2c6b19baf5ff0a70353aa28776"
SRC_URI="https://github.com/mrlotfi/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-qt/qtdbus"

MY_PN="${PN#*-}"

MPV_PLUGIN_FILES=( ${MY_PN}.so )

S="${WORKDIR}/${PN}-${SHA}"

src_compile() {
	emake "CC=$(tc-getCXX)" "PKG_CONFIG=$(tc-getPKG_CONFIG)"
}
