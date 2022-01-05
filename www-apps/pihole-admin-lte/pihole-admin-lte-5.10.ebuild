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

RDEPEND="dev-lang/php[fileinfo,filter,gd,intl,session,sqlite,tokenizer]
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
	dodoc "${FILESDIR}/${PN}-nginx-example.conf"
	webapp_src_install
}

pkg_postinst() {
	elog
	elog "An example nginx configuration snippet is available in"
	elog "${EROOT}/usr/share/${PF} in the file ${PN}-nginx-example.conf"
	webapp_pkg_postinst
}
