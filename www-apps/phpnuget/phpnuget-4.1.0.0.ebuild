# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WEBAPP_MANUAL_SLOT="yes"
inherit webapp

DESCRIPTION="Repository for NuGet with Chocolatey support."
HOMEPAGE="https://www.kendar.org/?p=/dotnet/phpnuget"
SRC_URI="https://www.kendar.org/?p=/dotnet/${PN}/${PN}.${PV}.zip -> ${P}.zip"

LICENSE="GPL-3+ PHP-3.01"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/php"
need_httpd_cgi

PATCHES=( "${FILESDIR}/phpnuget-fixes.patch" )

S="${WORKDIR}"

src_prepare() {
	local name
	for name in .gitignore 'composer.*' 'license*' '*.md' version '*.dist' '.*.yml' \
		'*managedfusion*'; do
		find . -type f -iname "$name" -delete || die
	done
	rm -R bin inc/PHPMailer/{examples,docs} data sample.web.config || die
	mv settings.sample.php settings.php || die
	default
}

src_install() {
	webapp_src_preinst
	insinto "${MY_HTDOCSDIR}"
	doins -r .
	webapp_server_configfile apache "${FILESDIR}/${PN}-apache-example.conf" "${PN}.conf"
	webapp_server_configfile nginx "${FILESDIR}/${PN}-nginx-example.conf" "${PN}.conf"
	newdoc "${FILESDIR}/${PN}-fpm-example.conf" "php-fpm-${PN}.conf"
	webapp_sqlscript mysql "${FILESDIR}/${PN}-nugetdb_usrs-schema.sql"
	insinto "/etc/${PN}"
	webapp_configfile "${MY_HTDOCSDIR}/settings.php"
	keepdir /var/lib/phpnuget/{db,packages} || die
	webapp_src_install
	keepdir "/var/lib/${PN}"
}
