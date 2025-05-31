# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@alcalzone/jsonl-db-3.1.1
	@alcalzone/proper-lockfile-4.1.3-0
	@andrewbranch/untar.js-1.0.3
	@colors/colors-1.6.0
	@dabh/diagnostics-2.0.3
	@homebridge/ciao-1.3.1
	@leichtgewicht/ip-codec-2.0.5
	@serialport/binding-mock-10.2.2
	@serialport/bindings-cpp-13.0.0
	@serialport/bindings-interface-1.2.2
	@serialport/parser-byte-length-13.0.0
	@serialport/parser-cctalk-13.0.0
	@serialport/parser-delimiter-12.0.0
	@serialport/parser-delimiter-13.0.0
	@serialport/parser-inter-byte-timeout-13.0.0
	@serialport/parser-packet-length-13.0.0
	@serialport/parser-readline-12.0.0
	@serialport/parser-readline-13.0.0
	@serialport/parser-ready-13.0.0
	@serialport/parser-regex-13.0.0
	@serialport/parser-slip-encoder-13.0.0
	@serialport/parser-spacepacket-13.0.0
	@serialport/stream-13.0.0
	@types/triple-beam-1.3.5
	@zwave-js/cc-15.6.0
	@zwave-js/config-15.6.0
	@zwave-js/core-15.6.0
	@zwave-js/host-15.6.0
	@zwave-js/nvmedit-15.6.0
	@zwave-js/serial-15.6.0
	@zwave-js/server-3.0.2
	@zwave-js/shared-15.4.0
	@zwave-js/testing-15.6.0
	@zwave-js/waddle-1.0.0
	alcalzone-shared-4.0.8
	alcalzone-shared-5.0.0
	ansi-colors-4.1.3
	ansi-regex-5.0.1
	ansi-styles-4.3.0
	async-3.2.6
	buffer-from-1.1.2
	cliui-8.0.1
	color-3.2.1
	color-convert-1.9.3
	color-convert-2.0.1
	color-name-1.1.3
	color-name-1.1.4
	color-string-1.9.1
	colorspace-1.1.4
	dayjs-1.11.13
	debug-4.4.0
	debug-4.4.1
	dns-packet-5.6.1
	emoji-regex-8.0.0
	enabled-2.0.0
	escalade-3.2.0
	eventemitter3-5.0.1
	fast-deep-equal-3.1.3
	fecha-4.2.3
	fflate-0.8.2
	file-stream-rotator-0.6.1
	fn.name-1.1.0
	fs-extra-10.1.0
	get-caller-file-2.0.5
	graceful-fs-4.2.11
	inherits-2.0.4
	is-arrayish-0.3.2
	is-fullwidth-code-point-3.0.0
	is-stream-2.0.1
	json-logic-js-2.0.5
	json5-2.2.3
	jsonfile-6.1.0
	kuler-2.0.0
	ky-1.8.1
	logform-2.7.0
	mdns-server-1.0.11
	minimist-1.2.8
	moment-2.30.1
	ms-2.1.3
	node-addon-api-8.3.0
	node-gyp-build-4.8.4
	nrf-intel-hex-1.4.0
	object-hash-3.0.0
	one-time-1.0.0
	p-queue-8.1.0
	p-timeout-6.1.4
	pathe-2.0.3
	readable-stream-3.6.2
	reflect-metadata-0.2.2
	require-directory-2.1.1
	retry-0.12.0
	safe-buffer-5.2.1
	safe-stable-stringify-2.5.0
	semver-7.7.2
	serialport-13.0.0
	signal-exit-3.0.7
	simple-swizzle-0.2.2
	source-map-0.6.1
	source-map-support-0.5.21
	stack-trace-0.0.10
	string-width-4.2.3
	string_decoder-1.3.0
	strip-ansi-6.0.1
	text-hex-1.0.0
	triple-beam-1.4.1
	tslib-2.8.1
	universalify-2.0.1
	util-deprecate-1.0.2
	winston-3.17.0
	winston-daily-rotate-file-5.0.0
	winston-transport-4.9.0
	wrap-ansi-7.0.0
	ws-8.18.2
	y18n-5.0.8
	yargs-17.7.2
	yargs-parser-21.1.1
	zwave-js-15.6.0

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
