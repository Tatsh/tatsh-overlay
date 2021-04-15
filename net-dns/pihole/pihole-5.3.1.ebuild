# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit bash-completion-r1

DESCRIPTION="Network-wide ad blocking (core)."
HOMEPAGE="https://pi-hole.net/"
SRC_URI="https://github.com/pi-hole/pi-hole/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND="acct-user/${PN}
	acct-group/${PN}"
RDEPEND="${DEPEND} net-dns/${PN}-ftl"

S="${WORKDIR}/pi-hole-${PV}"

src_prepare() {
	sed -r -e "s:coltable=.*:coltable=${EPREFIX}/usr/share/${PN}/COL_TABLE:" \
		-e "s:/opt/${PN}/:${EPREFIX}/usr/libexec/${PN}/:g" \
		-e "s:/etc/.${PN}/.*gravity-db.sh:${EPREFIX}/usr/libexec/${PN}/gravity-db.sh:" \
		-e "s:/usr/local/bin:${EPREFIX}/usr/bin:g" \
		-e "s:${PN}GitDir=.*:${PN}GitDir=${EPREFIX}/usr/share/${PN}:" \
		-e "s:gravityDBfile=.*:gravityDBfile=${EPREFIX}/var/db/${PN}/gravity.db:" \
		-e "s:gravityTEMPfile=.*:gravityTEMPfile=${EPREFIX}/var/db/${PN}/gravity_temp.db:" \
		-i gravity.sh || die
	# Randomise gravity update and update checker time time
	sed -i "s/59 1 /$((1 + RANDOM % 58)) $((3 + RANDOM % 2))/" \
		advanced/Templates/${PN}.cron || die
	sed -i "s/59 17/$((1 + RANDOM % 58)) $((12 + RANDOM % 8))/" \
		advanced/Templates/${PN}.cron || die
	default
}

src_install() {
	# dodir /etc/${PN}/dnsmasq.d

	insinto /etc/logrotate.d
	newins advanced/Templates/logrotate ${PN}

	exeinto /usr/libexec/${PN}
	doexe gravity.sh \
		advanced/Scripts/*.sh \
		advanced/Scripts/database_migration/gravity-db.sh

	insinto /usr/share/${PN}
	doins advanced/Templates/*.sql advanced/Scripts/COL_TABLE

	insinto /etc/${PN}
	newins advanced/01-${PN}.conf 01-${PN}.conf.default

	dobashcomp advanced/bash-completion/${PN}

	if ! use systemd; then
		insinto /etc/cron.d
		newins advanced/Templates/${PN}.cron ${PN}
	fi

	doman manpages/${PN}*

	dobin ${PN}
}

pkg_config() {
	if ! [ -d /var/db/${PN} ]; then
		# if ! [ -f /etc/${PN}/setupVars.conf ]; then
		# fi
		# Questions:
		# - Do you want to log queries? QUERY_LOGGING=true/false
		# - Select a privacy mode: https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh#L1210
		#   PRIVACY_LEVEL=0/1/2/3
		# - ${PN}_DNS_1 and ${PN}_DNS_2
		#   https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh#L1107
		# - Select protocols https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh#L820
		# - Select interface ${PN}_INTERFACE
		# - CACHE_SIZE int, default 10000
		/usr/libexec/${PN}/gravity.sh --force
	fi
}
