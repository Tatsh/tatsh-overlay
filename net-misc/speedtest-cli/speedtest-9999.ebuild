# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 eutils

DESCRIPTION="Command line interface for testing internet bandwidth using speedtest.net"
HOMEPAGE="https://github.com/sivel/speedtest-cli"
EGIT_REPO_URI="https://github.com/sivel/${PN}-cli.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python:2.7
${DEPEND}"

src_install() {
	insinto /usr/share/${PN}-cli
	doins "${PN}-cli" "${PN}-cli-3"

	dobin "${FILESDIR}/$PN"
	dodoc README.md
}

# kate: replace-tabs false;
