# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8,9,10} )
inherit python-single-r1

DESCRIPTION="mpv script to skip sponsored segments of YouTube videos"
HOMEPAGE="https://github.com/po5/mpv_sponsorblock"
SHA="29e7b75809107db2bb0c6c6eed0199e063aa75d2"
SRC_URI="https://github.com/po5/mpv_sponsorblock/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-video/mpv[lua]"

S="${WORKDIR}/${PN/-/_}-${SHA}"

PATCHES=( "${FILESDIR}/${PN}-fix-paths.patch" )

src_prepare() {
	default
	sed -r -e "s|@EPREFIX@|${EPREFIX}|g" -i sponsorblock.lua \
		sponsorblock_shared/sponsorblock.py || die
}

src_install() {
	insinto /usr/share/mpv/lua/
	doins sponsorblock.lua
	python_newscript "sponsorblock_shared/sponsorblock.py" "${PN/-/_}.py"
	einstalldocs
}

pkg_postinst() {
	einfo "To enable this plugin, do one of the following:"
	einfo
	einfo "1) Add --script=${EPREFIX}/usr/share/mpv/lua/sponsorblock.lua to your MPV configuration file"
	einfo
	einfo "2) Symbolically link the script in your MPV scripts directory:"
	einfo
	einfo "   mkdir -p ~/.config/mpv/scripts"
	einfo "   ln -s ${EPREFIX}/usr/share/mpv/lua/sponsorblock.lua ~/.config/mpv/scripts/"
	einfo
	einfo "Further configuration may be made in this file:"
	einfo
	einfo "  ~/.config/mpv/script-opts/sponsorblock.conf"
	einfo
	einfo "See the top of ${EPREFIX}/usr/share/mpv/lua/sponsorblock.lua for reference on options"
}
