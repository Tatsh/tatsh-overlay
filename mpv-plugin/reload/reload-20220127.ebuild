# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-plugin

MPV_REQ_USE="lua"

DESCRIPTION="mpv plugin for automatic reloading of slow/stuck video streams"
HOMEPAGE="https://github.com/4e6/mpv-reload"
SHA="c1219b6ac3ee3de887e6a36ae41a8e478835ae92"
SRC_URI="https://github.com/4e6/mpv-reload/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=(
	${PN}.lua
)

S="${WORKDIR}/mpv-${PN}-${SHA}"
