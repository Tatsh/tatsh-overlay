# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=true
inherit git-2 eutils distutils-r1

DESCRIPTION="Tweets #nowplaying messages from applications that play music and expose an mpris interface via D-Bus"
HOMEPAGE="https://github.com/Tatsh/mpris-tweeter"
EGIT_REPO_URI="https://github.com/Tatsh/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/tweepy"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}] ${RDEPEND}"

DOCS=( README.md )

src_compile() {
	echo 'Nothing to compile'
}

src_install() {
	exeinto /usr/bin
	doexe bin/mpris-tweeter
}
