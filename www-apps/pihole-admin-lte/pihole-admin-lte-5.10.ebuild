# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WEBAPP_MANUAL_SLOT="yes"
inherit webapp

MY_P="AdminLTE"
S="${WORKDIR}/${MY_P}-${PV}"

DESCRIPTION="Pi-hole Dashboard for stats and more"
HOMEPAGE="https://github.com/pi-hole/AdminLTE"
SRC_URI="https://github.com/pi-hole/AdminLTE/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-portage/portage-utils"
RDEPEND="app-admin/sudo
dev-lang/php[fileinfo,filter,gd,intl,session,sqlite,tokenizer]
	net-dns/pihole
	virtual/httpd-php"
need_httpd_cgi

PATCHES=(
	"${FILESDIR}/${PN}-0001-settings-disable-buttons-fix.patch"
	"${FILESDIR}/${PN}-0002-fix-paths.patch"
	"${FILESDIR}/${PN}-0003-footer-remove-update-check.patch"
	"${FILESDIR}/${PN}-0004-header-bug-fixes.patch"
)

src_prepare() {
	default
	find '(' \
		-iname 'LICENSE' -o \
		-name '*.css.map' -o \
		-name '*.js.map' -o \
		-name '*.md' -o \
		-name '.gitattributes' -o \
		-name '.gitignore' -o \
		-name '.user.php.ini' -o  \
		-name 'composer.json' -o \
		-name 'composer.lock' -o \
		-name 'package*.json' \
	')' -type f -delete || die
	rm -fR .github/ phpstan.neon.dist || die
}

src_install() {
	webapp_src_preinst
	insinto "${MY_HTDOCSDIR}"
	doins -r .
	webapp_server_configfile apache "${FILESDIR}/${PN}-apache-example.conf" \
		"${PN}.conf"
	webapp_server_configfile nginx "${FILESDIR}/${PN}-nginx-example.conf" \
		"${PN}.conf"
	if has_version 'dev-lang/php[fpm]'; then
		local -r php_ver=$(best_version dev-lang/php | sed -re 's/^([0-9]+)\.([0-9]+).*/\1.\2/')
		insinto "/etc/php/fpm-php${php_ver}/fpm.d"
		newins "${FILESDIR}/${PN}-fpm-example.conf" "${PN}.conf"
	fi
	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	mkdir -p "${ED}/etc/sudoers.d" "${ED}/var/lib/pihole" || die
	{ echo 'pihole ALL=(ALL) NOPASSWD: /usr/bin/pihole' > "${ED}/etc/sudoers.d/pihole"; } || die
	webapp_src_install
	touch "${ED}/var/lib/pihole/GitHubVersions" || die
	{ echo 'master master' > "${ED}/var/lib/pihole/localbranches"; } || die
	local -r core_ver=$(qatom $(best_version net-dns/pihole) | cut '-d ' -f3)
	local -r ftl_ver=$(qatom $(best_version net-dns/pihole-ftl) | cut '-d ' -f3)
	{ echo "${core_ver} ${PV} ${ftl_ver}" > "${ED}/var/lib/pihole/localversions"; } || die
}
