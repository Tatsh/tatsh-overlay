# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Heroku is a cloud platform as a service (PaaS) supporting several programming languages."
HOMEPAGE="https://toolbelt.heroku.com/standalone https://github.com/heroku/toolbelt"
SRC_URI="http://assets.heroku.com.s3.amazonaws.com/heroku-client/heroku-client.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="$WORKDIR/heroku-client"

src_install() {
	insinto /usr/share/heroku-client
	doins -r .
	fperms 0755 /usr/share/heroku-client/bin/heroku

	dosym /usr/share/heroku-client/bin/heroku /usr/bin/heroku
}
