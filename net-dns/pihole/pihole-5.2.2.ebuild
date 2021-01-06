# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Network-wide ad blocking (core)."
HOMEPAGE="https://pi-hole.net/"
SRC_URI="https://github.com/pi-hole/pi-hole/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	acct-user/${PN}
	acct-group/${PN}"
RDEPEND="${DEPEND} net-dns/pihole-ftl"
BDEPEND=""

S="${WORKDIR}/pi-hole-${PV}"

src_install() {
	dodir /etc/${PN}
	dodir /usr/libexec/${PN}
	dodir /etc/dnsmasq.d

	exeinto /usr/libexec/${PN}
	doexe gravity.sh \
		advanced/Scripts/*.sh \
		advanced/Scripts/COL_TABLE

	insinto /usr/share/bash-completion/completions
	doins advanced/bash-completion/pihole

	dobin ${PN}
}
