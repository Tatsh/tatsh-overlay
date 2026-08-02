# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pi-hole web interface (admin UI assets served by pihole-ftl)"
HOMEPAGE="https://github.com/pi-hole/web"
SRC_URI="https://github.com/pi-hole/web/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/web-${PV}"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-dns/pihole-ftl-6.0.0"

src_install() {
	insinto /var/www/html/admin
	doins -r .
	rm -rf "${ED}/var/www/html/admin/"{.github,CONTRIBUTING.md,README.md,package.json,package-lock.json,postcss.config.js,xo.config.js} || die
}
