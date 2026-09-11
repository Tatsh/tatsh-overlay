# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Shell script to access GitHub Gist."
HOMEPAGE="https://github.com/weakish/gister"
SRC_URI="https://github.com/weakish/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/jq
	dev-ruby/gist
	dev-vcs/git
	net-misc/curl
"

# The Makefile's first target is install, so the default src_compile would try
# to install into /usr/local.
src_compile() { :; }

src_install() {
	dobin bin/"${PN}"
	einstalldocs
}
