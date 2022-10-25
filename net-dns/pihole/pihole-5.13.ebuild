# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit bash-completion-r1 systemd

DESCRIPTION="Network-wide ad blocking (core)."
HOMEPAGE="https://pi-hole.net/"
SRC_URI="https://github.com/pi-hole/pi-hole/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="cron www"

DEPEND="acct-user/${PN}
	acct-group/${PN}"
FTL_VERSION="5.13"
RDEPEND="${DEPEND}
	>=net-dns/${PN}-ftl-${FTL_VERSION}
	app-admin/sudo
	sys-apps/iproute2"

S="${WORKDIR}/pi-hole-${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0002-path-changes.patch"
	"${FILESDIR}/${PN}-0003-logrotate-add-missingok-fix-.patch"
	"${FILESDIR}/${PN}-0004-more-path-fixes.patch"
	"${FILESDIR}/${PN}-0005-pihole-add-rc-service-to-res.patch"
	"${FILESDIR}/${PN}-0006-advanced-scripts-piholelogfl.patch"
	"${FILESDIR}/${PN}-0007-version.sh-path-fix.patch"
	"${FILESDIR}/${PN}-0008-fix-calling-valid_ip.patch"
	"${FILESDIR}/${PN}-0009-fix-path-in-generated-dhcp-c.patch"
	"${FILESDIR}/${PN}-0010-more-path-fixes.patch"
	"${FILESDIR}/${PN}-0011-piholedebug-gentoo-vhost-fix.patch"
	"${FILESDIR}/${PN}-0012-remove-updatecheck.patch"
	"${FILESDIR}/${PN}-0013-remove-more-unused.patch"
)

src_prepare() {
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

	insinto /etc
	echo "conf-dir=${EPREFIX}/etc/pihole/dnsmasq.d" > dnsmasq.conf
	doins dnsmasq.conf
	insinto /etc/${PN}/dnsmasq.d
	doins advanced/01-${PN}.conf advanced/06-rfc6761.conf

	dobashcomp advanced/bash-completion/${PN}

	if use cron; then
		insinto /etc/cron.d
		newins advanced/Templates/${PN}.cron ${PN}
	fi

	if use www; then
		insinto /usr/share/webapps/${PN}-blocking-page
		doins advanced/index.php
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

	systemd_dounit \
		"${FILESDIR}/${PN}-update-gravity-db."* \
		"${FILESDIR}/${PN}-update-macvendor-db."*
}

pkg_preinst() {
	local -r macvendor_uri="https://ftl.pi-hole.net/macvendor.db"
	ebegin 'Downloading macvendor.db file'
	wget "$macvendor_uri" -O "${D}/var/lib/${PN}/macvendor.db"
	eend $? 'Downloading macvendor.db failed'
	cat > "${PN}-update-macvendor-db" <<EOF
#!/bin/sh
wget ${macvendor_uri} -O ${ROOT}/var/lib/${PN}/macvendor.db
EOF
	exeinto /etc/cron.monthly
	doexe "${PN}-update-macvendor-db"
	local -r gravity_sql="${D}/usr/$(get_libdir)/pihole/Templates/gravity.db.sql"
	if ! [ -f "${ROOT}/var/lib/${PN}/gravity.db" ]; then
		ebegin 'Preparing gravity.db'
		pihole-FTL sqlite3 "${D}/var/lib/${PN}/gravity.db" < "${gravity_sql}"
		eend $? 'Preparation of gravity.db failed'
	fi
}

pkg_postrm() {
	rm -f "${ROOT}/var/lib/${PN}/macvendor.db"
}
