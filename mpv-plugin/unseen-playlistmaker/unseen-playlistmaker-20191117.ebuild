# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-plugin

MPV_REQ_USE="lua"

DESCRIPTION="mpv plugin for automatic reloading of slow/stuck video streams"
HOMEPAGE="https://github.com/4e6/mpv-reload"
SHA="9ee4843fe6153bcf86a15ddbde8958783bafd6e6"
SRC_URI="https://github.com/jonniek/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=(
	${PN}.lua
)

S="${WORKDIR}/${PN}-${SHA}"
