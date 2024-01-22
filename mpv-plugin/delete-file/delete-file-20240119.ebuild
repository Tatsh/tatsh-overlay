# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
USE_MPV="rdepend"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="Queue files for deletion on quit."
HOMEPAGE="https://github.com/zenyd/mpv-scripts"
SHA="3ad7502fe2d6575b395db5568afdf830872c85d0"
SRC_URI="https://github.com/zenyd/mpv-scripts/archive/${SHA}.tar.gz -> zenyd-mpv-scripts-${SHA:0:7}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN/-/_}.lua"
)

S="${WORKDIR}/mpv-scripts-${SHA}"
