# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="Play 3D side-by-side video as a 2D video and look around."
HOMEPAGE="https://github.com/dfaker/VR-reversal"
SHA="91f4aeed43b8febf099af10df13a24151256d8a7"
MY_PN="VR-reversal"
SRC_URI="https://github.com/dfaker/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	360plugin.lua
)

S="${WORKDIR}/${MY_PN}-${SHA}"

src_install() {
	mpv-plugin_src_install
	insinto /usr/$(get_libdir)/mpv
	doins script-opts/360plugin.conf
	if use autoload; then
		keepdir /etc/mpv/script-opts
		dosym ../../../usr/$(get_libdir)/mpv/360plugin.conf /etc/mpv/script-opts/360plugin.conf
	fi
}
