# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
PYTHON_COMPAT=( python3_{8,9,10} )
inherit mpv-plugin python-single-r1

DESCRIPTION="mpv script to skip sponsored segments of YouTube videos"
HOMEPAGE="https://github.com/po5/mpv_sponsorblock"
SHA="b6468d0a662e0a5aa8dedfe251a7050c3d12efe3"
SRC_URI="https://github.com/po5/${PN/-/_}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

S="${WORKDIR}/${PN/-/_}-${SHA}"

PATCHES=( "${FILESDIR}/${PN}-fix-paths.patch" )

MPV_PLUGIN_FILES=(
	"${PN:4}.lua"
	"${PN:4}_shared/main.lua"
	"${PN:4}_shared/${PN:4}.py"
)

src_prepare() {
	default
	sed -re "s|@EPREFIX@|${EPREFIX}|g" \
		-e "s|@LIBDIR@|$(get_libdir)|g" \
		-i sponsorblock.lua \
		sponsorblock_shared/sponsorblock.py || die
}

src_install() {
	mpv-plugin_src_install
	rm "${ED}/usr/$(get_libdir)/mpv/main.lua" \
		"${ED}/usr/$(get_libdir)/mpv/${PN:4}.py" || die
	insinto /usr/$(get_libdir)/mpv/${PN:4}_shared
	doins "${PN:4}_shared/main.lua" "${PN:4}_shared/${PN:4}.py"
}

pkg_postinst() {
	einfo
	einfo "Configuration may be made in this file:"
	einfo
	einfo "  ~/.config/mpv/script-opts/sponsorblock.conf"
	einfo
	einfo "See the top of https://github.com/po5/mpv_sponsorblock/blob/master/sponsorblock.lua for a reference on options."
	einfo
}
