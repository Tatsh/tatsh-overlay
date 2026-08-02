# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="Writes a list of edits made to the current video file to a file"
HOMEPAGE="https://github.com/paradox460/mpv-scripts"
SHA="c32a1c09258bdbaf1a895cd708cf1cf9a7281b1c"
SRC_URI="https://github.com/paradox460/mpv-scripts/archive/${SHA}.tar.gz -> paradox460-mpv-scripts-${SHA:0:7}.tar.gz"
S="${WORKDIR}/mpv-scripts-${SHA}/${PN}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN}.lua"
)
