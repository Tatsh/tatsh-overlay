# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="Fills the black bars on the side of a video with a blurred copy of its edges."
HOMEPAGE="https://github.com/occivink/mpv-scripts"
SHA="d0390c8e802c2e888ff4a2e1d5e4fb040f855b89"
SRC_URI="https://github.com/occivink/mpv-scripts/archive/${SHA}.tar.gz -> occivink-mpv-scripts-${SHA:0:7}.tar.gz"

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
	doins "../script-opts/${PN//-/_}.conf"
}
