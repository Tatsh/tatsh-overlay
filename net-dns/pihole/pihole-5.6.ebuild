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
IUSE="cron www"

DEPEND="acct-user/${PN}
	acct-group/${PN}"
FTL_VERSION="5.8.1"
RDEPEND="${DEPEND} >=net-dns/${PN}-ftl-${FTL_VERSION} app-admin/sudo"

S="${WORKDIR}/pi-hole-${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-cron-remove-flush-updatechecker.patch"
	"${FILESDIR}/${PN}-0002-path-changes-01.patch"
	"${FILESDIR}/${PN}-0002-path-changes-02.patch"
	"${FILESDIR}/${PN}-0002-path-changes-03.patch"
	"${FILESDIR}/${PN}-0003-logrotate-add-missingok-fix-paths.patch"
	"${FILESDIR}/${PN}-0004-more-path-fixes.patch"
	"${FILESDIR}/${PN}-0005-add-rc-service-to-restartdns.patch"
	"${FILESDIR}/${PN}-0006-advanced-scripts-piholelogflush-change-statefile.patch"
)

src_prepare() {
	rm advanced/Scripts/update{,check}.sh \
		advanced/Scripts/${PN}Checkout.sh \
		advanced/Templates/${PN}.sudo || die
	default
	sed -r -e "s/@EPREFIX@/${EPREFIX}/g" -e "s/@LIBDIR@/$(get_libdir)/g" \
		-e "s/@PIHOLE_FTL_VERSION@/${PIHOLE_FTL_VERSION}/g" \
		-e "s/@PIHOLE_VERSION@/${PV}/g" \
		-i gravity.sh \
			"$PN" \
			advanced/Scripts/*.sh \
			advanced/Scripts/database_migration/gravity-db.sh \
			advanced/Templates/${PN}.cron \
			advanced/index.php \
			advanced/01-${PN}.conf \
			advanced/06-rfc6761.conf \
			advanced/Templates/gravity_copy.sql \
			advanced/Templates/${PN}-FTL.service \
			manpages/${PN}-FTL.conf.5 \
			advanced/Templates/logrotate || die
}

src_install() {
	insinto /etc/logrotate.d
	newins advanced/Templates/logrotate ${PN}
	rm advanced/Templates/logrotate

	exeinto /usr/$(get_libdir)/${PN}
	doexe gravity.sh
	doexe advanced/Scripts/*.sh
	exeinto /usr/$(get_libdir)/${PN}/database_migration
	doexe advanced/Scripts/database_migration/*.sh
	insinto /usr/$(get_libdir)/${PN}
	doins advanced/Scripts/COL_TABLE
	insinto /usr/$(get_libdir)/${PN}/database_migration/gravity
	doins advanced/Scripts/database_migration/gravity/*

	insinto /usr/$(get_libdir)/${PN}/Templates
	doins -r advanced/Templates/*

	insinto /etc/${PN}/dnsmasq.d
	doins advanced/01-${PN}.conf advanced/06-rfc6761.conf

	dobashcomp advanced/bash-completion/${PN}

	if use cron; then
		insinto /etc/cron.d
		newins advanced/Templates/${PN}.cron ${PN}
	fi

	if use www; then
		insinto /usr/share/webapps/${PN}-blocking-page
		doins advanced/index.php advanced/blockingpage.css
	fi

	doman manpages/${PN}*
	einstalldocs

	dobin ${PN}

	# make sure the working directory exists
	diropts -m0755
	keepdir /var/lib/${PN}

	insinto /var/lib/${PN}
	doins "${FILESDIR}/setupVars.conf"

	echo "CONFIG_PROTECT=\"${EPREFIX}/var/lib/${PN}\"" > "${T}/90${PN}"
	doenvd "${T}/90${PN}"
}

# pkg_config() {
# 	if ! [ -d /var/lib/${PN} ]; then
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
# 		/usr/libexec/${PN}/gravity.sh --force
# 	fi
# }
