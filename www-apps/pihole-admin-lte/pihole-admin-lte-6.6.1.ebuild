# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pi-hole Dashboard for stats and more"
HOMEPAGE="https://github.com/pi-hole/web"
SRC_URI="https://github.com/pi-hole/web/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/web-${PV}"
LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64"

# As of v6 the interface consists of Lua pages served by pihole-FTL's embedded
# web server; the PHP application and its httpd configuration are gone.
RDEPEND=">=net-dns/pihole-ftl-6.0"

src_prepare() {
	default
	find '(' \
		-name '*.css.map' -o \
		-name '*.js.map' -o \
		-name '.gitattributes' -o \
		-name '.gitignore' \
	')' -type f -delete || die
	rm -fR .github package.json package-lock.json postcss.config.js \
		xo.config.js || die
}

src_install() {
	local DOCS=( README.md )
	einstalldocs
	rm CONTRIBUTING.md README.md || die
	# webserver.paths.webroot defaults to /var/www/html and
	# webserver.paths.webhome to /admin/.
	insinto /var/www/html/admin
	doins -r .
}
