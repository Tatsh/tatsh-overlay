# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="mpv plugin for automatic reloading of slow/stuck video streams"
HOMEPAGE="https://github.com/4e6/mpv-reload"
SHA="133d596f6d369f320b4595bbed1f4a157b7b9ee5"
SRC_URI="https://github.com/4e6/mpv-reload/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	"${PN}.lua"
)

S="${WORKDIR}/mpv-${PN}-${SHA}"
