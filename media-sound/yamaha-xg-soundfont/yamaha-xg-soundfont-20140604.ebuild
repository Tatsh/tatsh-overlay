# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Yamaha XG re-mapped soundfont by ZSF on SF2 forums."
HOMEPAGE="https://www.ronimusic.com/smp_ios_dls_files.htm"
SRC_URI="http://www.ronimusic.com/sf2/Yamaha_XG_Sound_Set.sf2"

LICENSE="Roni-Music"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ppc64 x86"

S="$WORKDIR"

src_unpack() {
	:
}

src_install() {
	insinto /usr/share/sounds/sf2
	newins "${DISTDIR}/Yamaha_XG_Sound_Set.sf2" yamaha_xg.sf2
}
