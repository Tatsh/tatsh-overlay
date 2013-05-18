# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Chinese flashcards application"
HOMEPAGE="http://www.mandarintools.com/"
SRC_URI="http://www.mandarintools.com/download/flashcards.zip"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+icon"

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
	icon? ( media-gfx/imagemagick net-misc/wget )
"

S="$WORKDIR"

JAR_FILENAME="flashapp.jar"
ICON_URL="http://www.mandarintools.com/images/zi.ico"

src_install() {
	local path_to_jar="$EPREFIX/usr/share/${PN}/${JAR_FILENAME}"

	insinto /usr/share/$PN
	doins "${JAR_FILENAME}"

	cat << SCRIPT > flashcards
#!/bin/sh
java -jar "$path_to_jar"
SCRIPT

	exeinto /usr/bin
	doexe flashcards

	if use icon; then
		wget "$ICON_URL"
		convert zi.ico zi.png
		local icon="$(du -b zi*.png | sort | tail -n 1 | cut -f 2)"
		newicon "$icon" "${PN}.png"

		make_desktop_entry flashcards "Chinese Flashcards" "/usr/share/pixmaps/${PN}.png" Education
	fi
}

# kate: replace-tabs false;
