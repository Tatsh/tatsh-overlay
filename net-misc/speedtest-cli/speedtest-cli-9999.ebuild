# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 eutils

DESCRIPTION="Command line interface for testing internet bandwidth using speedtest.net"
HOMEPAGE="https://github.com/sivel/speedtest-cli"
EGIT_REPO_URI="https://github.com/sivel/speedtest-cli.git"

LICENSE="EULA" # No license specified
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python:2.7
${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-python2.7.patch
}

src_install() {
	dobin "$PN"
	dodoc README.md
}

# kate: replace-tabs false;
