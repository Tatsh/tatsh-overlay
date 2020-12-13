# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pam systemd meson

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://cgit.freedesktop.org/libfprint/fprintd/"
MY_SHA="7d22a2b5b9d323638bb213aefb8627d897c8e482"
SRC_URI="https://gitlab.freedesktop.org/libfprint/fprintd/-/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk-doc +pam static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	>=sys-auth/libfprint-1.90.1
	sys-auth/polkit
	sys-apps/systemd
	pam? ( sys-libs/pam )
"
DEPEND="${RDEPEND}
	dev-util/intltool
	gtk-doc? (
		dev-util/gtk-doc
		dev-util/gtk-doc-am
		dev-libs/libxml2
	)
	sys-libs/pam_wrapper
"

S="${WORKDIR}/${PN}-v${PV}-${MY_SHA}"

src_prepare() {
	# Remove test dep checks
	sed -e "/.*'dbusmock': true.*/d" -i meson.build || die "sed failed"
	sed -e '/^pam_wrapper_dep =.*/d' -i meson.build || die "sed failed"
	default
}

src_configure() {
	local emesonargs=(
		-Dsystemd_system_unit_dir=$(systemd_get_systemunitdir)
		-Dman=true
		-Dgtk_doc=$(usex gtk-doc true false)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	keepdir /var/lib/fprint
	find "${D}" -name "*.la" -delete || die
	dodoc AUTHORS NEWS README{,.transifex} TODO
	newdoc pam/README README.pam_fprintd
	if use gtk-doc; then
		insinto /usr/share/doc/${PF}/html
		doins doc/{fprintd-docs,version}.xml
		insinto /usr/share/doc/${PF}/html/dbus
		doins doc/dbus/net.reactivated.Fprint.{Device,Manager}.ref.xml
	fi
}

pkg_postinst() {
	elog "Please take a look at README.pam_fprintd for integration docs."
}
