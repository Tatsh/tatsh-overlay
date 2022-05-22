# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LUA_COMPAT=( lua5-1 luajit )
inherit lua

DESCRIPTION="API to allow scripts to create interactive scrollable lists in mpv player."
HOMEPAGE="https://github.com/CogentRedTester/mpv-scroll-list"
SHA="36a37c0ce6c33cce1470df0f535300d0cf698eff"
SRC_URI="https://github.com/CogentRedTester/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND} media-video/mpv[lua]"

S="${WORKDIR}/${PN}-${SHA}"

_install_module() {
	insinto "$(lua_get_lmod_dir)"
	doins "${PN:4}.lua"
}

src_install() {
	lua_foreach_impl _install_module
	einstalldocs
}
