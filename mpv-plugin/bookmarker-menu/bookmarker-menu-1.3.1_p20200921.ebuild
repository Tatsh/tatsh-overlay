# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"

USE_MPV="rdepend"

inherit mpv-plugin

DESCRIPTION="A bookmarker menu to manage all your bookmarks in MPV"
HOMEPAGE="https://github.com/NurioHin/mpv-bookmarker"
SHA="aef6a1a64de57a97df0c7a396ea3f9b959f487ad"
SRC_URI="https://github.com/NurioHin/mpv-bookmarker/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/mpv-bookmarker-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN}.lua"
)
