# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"

USE_MPV="rdepend"

inherit mpv-plugin

DESCRIPTION="Crop the current video in a visual manner."
HOMEPAGE="https://github.com/occivink/mpv-scripts"
SHA="01f3e99558915bb715b614d7f4b052230360eb21"
SRC_URI="https://github.com/occivink/mpv-scripts/archive/${SHA}.tar.gz -> occivink-mpv-scripts-${SHA:0:7}.tar.gz"
S="${WORKDIR}/mpv-scripts-${SHA}/scripts"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN}.lua"
)

src_install() {
	mpv-plugin_src_install
	insinto /etc/mpv/script-opts
	doins "../script-opts/${PN}.conf"
}
