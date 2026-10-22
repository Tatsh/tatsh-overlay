# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Self-hosted dashboard that puts all your feeds in one place"
HOMEPAGE="https://github.com/glanceapp/glance"
SRC_URI="https://github.com/glanceapp/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="AGPL-3 Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="acct-group/glance
	acct-user/glance"
BDEPEND=">=dev-lang/go-1.27.1:="

src_compile() {
	ego build -o "${PN}" \
		-ldflags "-X github.com/glanceapp/glance/internal/glance.buildVersion=v${PV}" .
}

src_install() {
	dobin "${PN}"
	einstalldocs
	dodoc docs/*.md

	insinto /etc/glance
	newins docs/glance.yml glance.yml

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"
}
