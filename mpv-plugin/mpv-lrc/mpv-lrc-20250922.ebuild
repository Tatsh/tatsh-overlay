# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"

USE_MPV="rdepend"

inherit mpv-plugin

DESCRIPTION="Synchronize lyrics with mpv"
HOMEPAGE="https://github.com/guidocella/mpv-lrc"
SHA="bb1c653a05e382dddef1f702745be76c17f786d0"
SRC_URI="https://github.com/guidocella/mpv-lrc/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN:4}.lua"
)

src_install() {
	mpv-plugin_src_install
	insinto /etc/mpv/script-opts
	doins "script-opts/${PN:4}.conf"
	dobin lrc.sh
}
