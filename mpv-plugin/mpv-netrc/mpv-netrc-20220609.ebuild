# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="Reads ~/.netrc and sets up authorisation for URIs."
HOMEPAGE="https://github.com/Tatsh/mpv-netrc"
SHA="d4c915e0deeb695f2da2045fbd88bc719de41de3"
SRC_URI="https://github.com/Tatsh/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

MPV_PLUGIN_FILES=(
	${PN:4}.lua
)

S="${WORKDIR}/${PN}-${SHA}"
