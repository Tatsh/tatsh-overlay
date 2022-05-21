# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-plugin

MPV_REQ_USE="lua"

DESCRIPTION="Reads ~/.netrc and sets up authorisation for URIs."
HOMEPAGE="https://github.com/Tatsh/mpv-netrc"
SHA="da40a39a32a1f1cf27a3abbc73ac2faceded06c6"
SRC_URI="https://github.com/Tatsh/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=(
	${PN:4}.lua
)

S="${WORKDIR}/${PN}-${SHA}"
