# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_COMMIT="079be662dde374a383646256108a4974c2bc7796"

DESCRIPTION="Irssi plugin to connect to a Quassel core."
HOMEPAGE="https://github.com/phhusson/quassel-irssi"
SRC_URI="https://github.com/phhusson/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	net-irc/irssi
	net-libs/quasselc
"
DEPEND="
	${RDEPEND}
	dev-libs/glib:2
"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-irssi-1.x.patch" )

src_compile() {
	# Without SYSTEM_QUASSELC the build uses the bundled QuasselC checkout,
	# which the archive does not contain because it is a submodule.
	emake -C core CC="$(tc-getCC)" SYSTEM_QUASSELC=1
}

src_install() {
	# install derives its destination from DESTDIR and LIBDIR.
	emake -C core DESTDIR="${D}" "LIBDIR=/usr/$(get_libdir)" \
		SYSTEM_QUASSELC=1 install

	einstalldocs
}

pkg_postinst() {
	elog "Add a Quassel chatnet and server to ~/.irssi/config:"
	elog
	elog "  chatnets = { quassel = { type = \"Quassel\"; }; };"
	elog "  servers = ("
	elog "    { address = \"core.example.net\"; port = \"4242\";"
	elog "      chatnet = \"quassel\"; use_tls = \"yes\"; password = \"...\"; }"
	elog "  );"
	elog
	elog "Then run /load quassel followed by /connect quassel."
	elog
	# irssi has no subslot, so nothing forces this rebuild automatically.
	elog "The module records the irssi ABI version it was built against."
	elog "Re-emerge it after every net-irc/irssi upgrade or irssi will refuse"
	elog "to load it."
}
