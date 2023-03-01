# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="Queue files for deletion on quit."
HOMEPAGE="https://github.com/occivink/mpv-scripts"
SHA="af360f332897dda907644480f785336bc93facf1"
SRC_URI="https://github.com/occivink/mpv-scripts/archive/${SHA}.tar.gz -> zenyd-mpv-scripts-${SHA:0:7}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN}.lua"
)

S="${WORKDIR}/mpv-scripts-${SHA}/scripts"

src_install() {
	mpv-plugin_src_install
	insinto /etc/mpv/script-opts
	doins "../script-opts/${PN}.conf"
}
