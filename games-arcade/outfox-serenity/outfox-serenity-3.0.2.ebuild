# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The community pack content for Project OutFox (includes volume 1.5)"
HOMEPAGE="https://github.com/TeamRizu/OutFox-Serenity"
SRC_URI="https://github.com/TeamRizu/OutFox-Serenity/releases/download/v${PV:0:3}s1/OutFox.Serenity.All.In.One.v${PV:0:3}s1.TP.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	insinto /opt/outfox/Songs
	doins -r OutFox*
}
