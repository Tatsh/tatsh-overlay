# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils bash-completion-r1

DESCRIPTION="Command-line tool for managing WordPress installations."
HOMEPAGE="https://wp-cli.org/"
SRC_URI="https://github.com/wp-cli/wp-cli/releases/download/v${PV}/${P}.phar
	https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash -> ${P}-completion.bash
	https://raw.githubusercontent.com/wp-cli/wp-cli/master/CONTRIBUTING.md -> ${P}-CONTRIBUTING.md
	https://raw.githubusercontent.com/wp-cli/wp-cli/master/LICENSE -> ${P}-LICENSE
	https://raw.githubusercontent.com/wp-cli/wp-cli/master/README.md -> ${P}-README.md"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/php"
DEPEND="${RDEPEND}"

S="$WORKDIR"

src_unpack () {
	for i in "${DISTDIR}"/*.md \
		"${DISTDIR}"/*-LICENSE \
		"${DISTDIR}"/*-completion.bash; do
		cp -L "$i" "${S}/${i##*-}"
	done
	cp -L "$DISTDIR"/* "$S"

}

src_install () {
	cd "${S}"
	exeinto "/usr/share/${PN}/"
	doexe ${P}.phar
	fperms 0755 "/usr/share/${PN}/${P}.phar"

	dosym "/usr/share/${PN}/${P}.phar" /usr/bin/wp
	dodoc CONTRIBUTING.md README.md LICENSE

	newbashcomp completion.bash wp
}
