# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="javascript"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="Writes a list of edits made to the current video file to a file"
HOMEPAGE="https://github.com/paradox460/mpv-scripts"
SHA="ada64a06e9888fb42389f8349d598399e5fb8e32"
SRC_URI="https://github.com/paradox460/mpv-scripts/archive/${SHA}.tar.gz -> paradox460-mpv-scripts-${SHA:0:7}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN}.js"
)

DOCS=( README.md bulkedit.fish )

S="${WORKDIR}/mpv-scripts-${SHA}/writeedits"
