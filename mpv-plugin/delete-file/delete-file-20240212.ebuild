# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"

USE_MPV="rdepend"

inherit mpv-plugin

DESCRIPTION="Queue files for deletion on quit."
HOMEPAGE="https://github.com/zenyd/mpv-scripts"
SHA="9bdce0050144cb24f92475f7bdd77180e0e4c26b"
SRC_URI="https://github.com/zenyd/mpv-scripts/archive/${SHA}.tar.gz -> zenyd-mpv-scripts-${SHA:0:7}.tar.gz"
S="${WORKDIR}/mpv-scripts-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN/-/_}.lua"
)
