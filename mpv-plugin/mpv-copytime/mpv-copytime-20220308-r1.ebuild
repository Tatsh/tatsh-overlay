# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"

USE_MPV="rdepend"

inherit mpv-plugin

DESCRIPTION="Queue files for deletion on quit."
HOMEPAGE="https://github.com/zenyd/mpv-scripts"
SHA="10b53d507085ba2deda301b6fab3397eee275b71"
SRC_URI="https://github.com/Arieleg/mpv-${SPECIAL_NAME}/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/mpv-${SPECIAL_NAME}-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

SPECIAL_NAME="copyTime"

MPV_PLUGIN_FILES=( copyTime.lua )
