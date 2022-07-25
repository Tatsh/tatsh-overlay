# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The community pack content for Project OutFox (includes volume 1.5)"
HOMEPAGE="https://github.com/TeamRizu/OutFox-Serenity"
SRC_URI="https://github.com/TeamRizu/OutFox-Serenity/releases/download/v1.5-rc2/OutFox.Serenity.Winter.Update.RC2.rar -> ${P}.rar"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="games-arcade/stepmania-outfox"
BDEPEND="app-arch/unrar"

src_unpack() {
	local archive
	for archive in ${A}; do
		case "${archive}" in
			*.rar)
				ls -la ..
				unrar x "${DISTDIR}/${archive}" "${WORKDIR}/${P}/"
				;;
			*)
				unpack "${archive}"
				;;
		esac
	done
}

src_install() {
	insinto /opt/stepmania-outfox/Songs
	doins -r OutFox*
}
