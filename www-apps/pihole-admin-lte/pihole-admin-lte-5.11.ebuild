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

BDEPEND="app-misc/jq app-portage/portage-utils"
RDEPEND="app-admin/sudo
	dev-lang/php[fileinfo,filter,gd,intl,session,sqlite,tokenizer]
	net-dns/pihole
	virtual/httpd-php"
need_httpd_cgi

PATCHES=(
	"${FILESDIR}/${PN}-0001-path-changes.patch"
	"${FILESDIR}/${PN}-0002-settings-disable-power-off-a.patch"
	"${FILESDIR}/${PN}-0003-footer-remove-update-message.patch"
	"${FILESDIR}/${PN}-0004-header-add-hwmon_name.patch"
)

pkg_setup() {
	webapp_pkg_setup
	local -r ph_ver=$({ curl -s 'https://api.github.com/repos/pi-hole/pi-hole/releases/latest' || die; } | jq -r .tag_name)
	local -r web_ver=$({ curl -s 'https://api.github.com/repos/pi-hole/AdminLTE/releases/latest' || die; } | jq -r .tag_name)
	local -r ftl_ver=$({ curl -s 'https://api.github.com/repos/pi-hole/FTL/releases/latest' || die; } | jq -r .tag_name)
	{ echo "${ph_ver} ${web_ver} ${ftl_ver}" > "${T}/GitHubVersions"; } || die
}

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
	newdoc "${FILESDIR}/${PN}-fpm-example.conf" "php-fpm-${PN}.conf"
	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	mkdir -p "${ED}/etc/sudoers.d" "${ED}/var/lib/pihole" || die
	{ echo 'pihole ALL=(ALL) NOPASSWD: /usr/bin/pihole' > \
		"${ED}/etc/sudoers.d/pihole"; } || die
	webapp_src_install
	fperms 0600 /etc/sudoers.d/pihole
	fowners root:0 /etc/sudoers.d/pihole
	insinto /var/lib/pihole
	doins "${T}/GitHubVersions"
	{ echo 'master master master' > \
		"${ED}/var/lib/pihole/localbranches"; } || die
	local -r core_ver=$({
		qatom -q "$(best_version net-dns/pihole)" || \
			die 'qatom failed to get net-dns/pihole version'; } |
			cut '-d ' -f3)
	local -r ftl_ver=$({
		qatom -q "$(best_version net-dns/pihole-ftl)" || \
			die 'qatom failed to get FTL version'; } |
			cut '-d ' -f3)
	{ echo "v${core_ver} v${PV} v${ftl_ver}" > \
		"${ED}/var/lib/pihole/localversions"; } || die
}
