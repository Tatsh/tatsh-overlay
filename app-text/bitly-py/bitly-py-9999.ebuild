# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Command-line bit.ly URL generator"
HOMEPAGE="https://gist.github.com/Tatsh/5073663"
EGIT_REPO_URI="https://gist.github.com/5073663.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
PYTHON_DEPEND="2"

src_prepare() {
	cp bitly.py bitly
}

src_install() {
	exeinto /usr/bin
	doexe bitly
}

# kate: replace-tabs false;
