# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-3.0.0
	color-3.2.1
	wrap-ansi-7.0.0
	is-stream-2.0.1
	cliui-8.0.1
	@serialport/parser-regex-13.0.0
	triple-beam-1.4.1
	@zwave-js/nvmedit-15.0.0
	colorspace-1.1.4
	color-convert-2.0.1
	inherits-2.0.4
	node-gyp-build-4.8.4
	universalify-2.0.1
	ms-2.1.3
	json5-2.2.3
	ansi-styles-4.3.0
	@zwave-js/testing-15.0.2
	@zwave-js/shared-15.0.0
	yargs-17.7.2
	@serialport/bindings-interface-1.2.2
	async-3.2.6
	string-width-4.2.3
	nrf-intel-hex-1.4.0
	p-timeout-6.1.4
	@serialport/parser-ready-13.0.0
	dayjs-1.11.13
	escalade-3.2.0
	util-deprecate-1.0.2
	@zwave-js/cc-15.0.2
	get-caller-file-2.0.5
	text-hex-1.0.0
	zwave-js-15.0.2
	tslib-2.8.1
	kuler-2.0.0
	@zwave-js/core-15.0.0
	minimist-1.2.8
	@homebridge/ciao-1.3.1
	@serialport/parser-readline-13.0.0
	@alcalzone/proper-lockfile-4.1.3-0
	@serialport/stream-13.0.0
	source-map-0.6.1
	@serialport/parser-cctalk-13.0.0
	color-convert-1.9.3
	@serialport/binding-mock-10.2.2
	string_decoder-1.3.0
	pathe-2.0.3
	signal-exit-3.0.7
	fast-deep-equal-3.1.3
	mdns-server-1.0.11
	retry-0.12.0
	@serialport/parser-delimiter-13.0.0
	file-stream-rotator-0.6.1
	fflate-0.8.2
	@serialport/parser-readline-12.0.0
	ansi-regex-5.0.1
	ansi-colors-4.1.3
	@andrewbranch/untar.js-1.0.3
	alcalzone-shared-5.0.0
	strip-ansi-6.0.1
	enabled-2.0.0
	eventemitter3-5.0.1
	emoji-regex-8.0.0
	ky-1.7.5
	object-hash-3.0.0
	y18n-5.0.8
	source-map-support-0.5.21
	@dabh/diagnostics-2.0.3
	@types/triple-beam-1.3.5
	@zwave-js/serial-15.0.2
	@serialport/parser-packet-length-13.0.0
	is-fullwidth-code-point-3.0.0
	readable-stream-3.6.2
	@zwave-js/config-15.0.1
	jsonfile-6.1.0
	yargs-parser-21.1.1
	color-name-1.1.3
	graceful-fs-4.2.11
	node-addon-api-8.3.0
	json-logic-js-2.0.5
	one-time-1.0.0
	semver-7.7.1
	@alcalzone/jsonl-db-3.1.1
	buffer-from-1.1.2
	alcalzone-shared-4.0.8
	@serialport/parser-delimiter-12.0.0
	fn.name-1.1.0
	@serialport/parser-slip-encoder-13.0.0
	dns-packet-5.6.1
	fecha-4.2.3
	@serialport/bindings-cpp-13.0.0
	color-name-1.1.4
	p-queue-8.1.0
	winston-3.17.0
	require-directory-2.1.1
	serialport-13.0.0
	moment-2.30.1
	simple-swizzle-0.2.2
	@leichtgewicht/ip-codec-2.0.5
	@serialport/parser-inter-byte-timeout-13.0.0
	@zwave-js/host-15.0.1
	safe-stable-stringify-2.5.0
	winston-daily-rotate-file-5.0.0
	@serialport/parser-spacepacket-13.0.0
	ws-8.18.1
	logform-2.7.0
	debug-4.4.0
	stack-trace-0.0.10
	safe-buffer-5.2.1
	fs-extra-10.1.0
	@colors/colors-1.6.0
	reflect-metadata-0.2.2
	@serialport/parser-byte-length-13.0.0
	winston-transport-4.9.0
	color-string-1.9.1
	is-arrayish-0.3.2
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

LICENSE="0BSD Apache-2.0 BSD BSD-2 ISC MIT"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist-cjs/bin/"{client,server}.js
	dosym "../$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist-cjs/bin/client.js" /usr/bin/zwave-client
	dosym "../$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist-cjs/bin/server.js" /usr/bin/zwave-server
	insinto /etc
	doins "${FILESDIR}/${PN}.config.js"
	systemd_newunit "${FILESDIR}/${PN}.service" "${PN}@.service"
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
	elog "  systemctl enable --now ${PN}@\$(systemd-escape --path /dev/ttyACM0)"
	elog
}
