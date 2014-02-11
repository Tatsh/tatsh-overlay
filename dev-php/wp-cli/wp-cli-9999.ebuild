# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils git-2 bash-completion-r1

DESCRIPTION="Command-line tool for managing WordPress installations."
HOMEPAGE="https://github.com/wp-cli/wp-cli"
EGIT_REPO_URI="git://github.com/wp-cli/wp-cli.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile () {
	cd "${S}"
	curl -sS https://getcomposer.org/installer | php
	php composer.phar install --no-dev
}

src_install () {
	cd "${S}"
	insinto /usr/share/wp-cli/
	doins -r bin features php templates vendor
	fperms 0755 /usr/share/wp-cli/bin/wp

	dosym /usr/share/wp-cli/bin/wp /usr/bin/wp
	dodoc CONTRIBUTING.md LICENSE.txt README.md

	newbashcomp "./utils/wp-completion.bash" wp-cli
}
