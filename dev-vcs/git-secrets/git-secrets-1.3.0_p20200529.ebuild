# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Prevents you from committing passwords and other sensitive information to a git repository."
HOMEPAGE="https://github.com/awslabs/git-secrets"
MY_SHA="80230afa8c8bdeac766a0fece36f95ffaa0be778"
SRC_URI="https://github.com/awslabs/git-secrets/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-vcs/git-2.10.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_SHA}"

src_compile () {
	emake man
}

src_install () {
	emake DESTDIR="${D}" PREFIX=/usr install
	doman "${PN}.1"
	einstalldocs
}
