# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
inherit meson python-single-r1 systemd

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://gitlab.freedesktop.org/libfprint/fprintd"
SHA="b54a007ccf58ac0ae074c7151b223f35cbd17306"
SRC_URI="https://gitlab.freedesktop.org/libfprint/fprintd/-/archive/v${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="gtk-doc +pam static-libs systemd test"
REQUIRED_USE="systemd? ( pam )
	test? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-libs/dbus-glib
	dev-libs/glib:2
	>=sys-auth/libfprint-${PV}
	sys-auth/polkit
	systemd? ( sys-apps/systemd )
	pam? ( sys-libs/pam )"
DEPEND="${RDEPEND}
	dev-util/intltool
	gtk-doc? (
		dev-util/gtk-doc
		dev-util/gtk-doc-am
		dev-libs/libxml2
	)"
# shellcheck disable=SC2016
BDEPEND="test? (
		$(python_gen_cond_dep 'dev-python/python-dbusmock[${PYTHON_USEDEP}]')
		pam? ( sys-libs/pam_wrapper )
	)"

S="${WORKDIR}/${PN}-v${PV}-${SHA}"

DOCS=( pam/README )

src_prepare() {
	# Remove test dep checks
	if ! use test; then
		sed -e "/.*'dbusmock': true.*/d" -i meson.build || die "sed failed"
		sed -e "/.*'pypamtest': .*/d" -i meson.build || die "sed failed"
		sed -e "/^subdir('tests')/d" -i meson.build || die "sed failed"
		sed -e "/With address sanitizer: /d" -i meson.build || die "sed failed"
	fi
	default
}

src_configure() {
	local emesonargs=(
		"-Dsystemd_system_unit_dir=$(systemd_get_systemunitdir)"
		-Dman=true
		"-Dgtk_doc=$(usex gtk-doc true false)"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	keepdir /var/lib/fprint
	find "${D}" -name "*.la" -delete || die
	einstalldocs
	if use gtk-doc; then
		insinto "/usr/share/doc/${PF}/html"
		doins doc/{fprintd-docs,version}.xml
		insinto "/usr/share/doc/${PF}/html/dbus"
		doins doc/dbus/net.reactivated.Fprint.{Device,Manager}.ref.xml
	fi
}

pkg_postinst() {
	elog "Please take a look at README.pam_fprintd for integration docs."
}
