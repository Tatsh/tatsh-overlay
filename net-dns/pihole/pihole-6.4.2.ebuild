# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 systemd

DESCRIPTION="Network-wide ad blocking (core, v6 with built-in webserver)"
HOMEPAGE="https://pi-hole.net/"
SRC_URI="https://github.com/pi-hole/pi-hole/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pi-hole-${PV}"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cron"

FTL_VERSION="6.6.2"
WEB_VERSION="6.5"

DEPEND="acct-user/${PN}
	acct-group/${PN}"
RDEPEND="${DEPEND}
	>=net-dns/${PN}-ftl-${FTL_VERSION}
	>=net-dns/${PN}-web-${WEB_VERSION}
	app-admin/sudo
	sys-apps/iproute2"

src_prepare() {
	default
	# Upstream hard-codes the Pi-hole installer paths that the Debian/Ubuntu
	# automated installer creates (/opt/pihole, /etc/.pihole, /usr/local/bin).
	# Rewrite them to Gentoo FHS-correct equivalents.
	local libdir
	libdir=$(get_libdir)
	sed -i \
		-e "s|/opt/pihole|${EPREFIX}/usr/${libdir}/${PN}|g" \
		-e "s|/usr/local/bin|${EPREFIX}/usr/bin|g" \
		-e "s|/etc/\\.pihole/advanced/Scripts|${EPREFIX}/usr/${libdir}/${PN}|g" \
		gravity.sh \
		"${PN}" \
		advanced/Scripts/*.sh \
		advanced/Scripts/database_migration/*.sh \
		advanced/Templates/*.sh \
		advanced/Templates/pihole.cron \
		advanced/Templates/gravity_copy.sql \
		|| die
}

src_install() {
	insinto /etc/logrotate.d
	newins advanced/Templates/logrotate "${PN}"
	rm advanced/Templates/logrotate || die

	exeinto "/usr/$(get_libdir)/${PN}"
	doexe gravity.sh
	doexe advanced/Scripts/*.sh
	exeinto "/usr/$(get_libdir)/${PN}/database_migration"
	doexe advanced/Scripts/database_migration/*.sh
	insinto "/usr/$(get_libdir)/${PN}"
	doins advanced/Scripts/COL_TABLE
	insinto "/usr/$(get_libdir)/${PN}/database_migration/gravity"
	doins advanced/Scripts/database_migration/gravity/*

	insinto "/usr/$(get_libdir)/${PN}/Templates"
	doins -r advanced/Templates/*

	newbashcomp "advanced/bash-completion/${PN}.bash" "${PN}"

	if use cron; then
		insinto /etc/cron.d
		newins "advanced/Templates/${PN}.cron" "${PN}"
	fi

	doman "manpages/${PN}"*
	einstalldocs

	dobin "${PN}"

	# Working / state directory for FTL's gravity DB, dhcp leases, etc.
	# pihole-FTL creates the SQLite databases on first run.
	diropts -m0755
	keepdir "/var/lib/${PN}"

	systemd_dounit "${FILESDIR}/${PN}-update-gravity-db."*
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Pi-hole v6 ships an embedded webserver (CivetWeb) inside pihole-FTL."
		elog "lighttpd and PHP from the v5 stack are no longer required and can be"
		elog "removed if you do not use them for anything else."
		elog
		elog "The default admin UI listens on http://<host>:80/admin/."
		elog "Override the listen port in /etc/pihole/pihole.toml under [webserver]."
		elog
		elog "Configuration moved from /etc/pihole/setupVars.conf (key=value) to"
		elog "/etc/pihole/pihole.toml. pihole-FTL auto-creates pihole.toml on first"
		elog "run; if you are migrating from v5 back up setupVars.conf first."
	fi
}
