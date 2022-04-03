# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/20220402/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

DOCS=( "${FILESDIR}/${PN}.keys.js.example" )

RDEPEND="net-libs/nodejs"

src_prepare() {
	find . '(' -iname '*.ts' \
		-o -iname '*.ts.map' \
		-o -iname '*.js.map' ')' -delete || die
	default
}

src_install() {
	insinto /usr/$(get_libdir)/node_modules
	doins -r lib/node_modules/*
	fperms 0755 /usr/$(get_libdir)/node_modules/@zwave-js/server/dist/bin/{client,server}.js
	dosym ../$(get_libdir)/node_modules/@zwave-js/server/dist/bin/client.js /usr/bin/zwave-client
	dosym ../$(get_libdir)/node_modules/@zwave-js/server/dist/bin/server.js /usr/bin/zwave-server
	insinto /etc
	doins "${FILESDIR}/${PN}.config.js"
	systemd_newunit "${FILESDIR}/${PN}.service" "${PN}@.service"
	einstalldocs
}

pkg_postinst() {
	elog
	elog "You need to set up security keys. See"
	elog "${PN}.keys.js.example in the documentation directory for more"
	elog "information."
	elog
	elog "systemd: To create the service, the device path must be specified"
	elog "with systemd-escape:"
	elog
	elog "  systemctl enable --now ${PN}@$(systemd-escape --path /dev/ttyACM0)"
	elog
}
