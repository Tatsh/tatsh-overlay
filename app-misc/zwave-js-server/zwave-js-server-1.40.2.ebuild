# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.40.2
	cacheable-request-10.2.14
	minimist-1.2.8
	@zwave-js/serial-14.3.6
	@zwave-js/config-14.3.4
	@serialport/parser-readline-11.0.0
	eventemitter3-5.0.1
	resolve-alpn-1.2.1
	color-string-1.9.1
	one-time-1.0.0
	execa-5.1.1
	logform-2.7.0
	node-addon-api-7.0.0
	onetime-5.1.2
	alcalzone-shared-4.0.8
	@serialport/parser-cctalk-12.0.0
	escalade-3.2.0
	shebang-regex-3.0.0
	winston-daily-rotate-file-5.0.0
	buffer-from-1.1.2
	@serialport/bindings-interface-1.2.2
	json5-2.2.3
	util-deprecate-1.0.2
	source-map-support-0.5.21
	human-signals-2.1.0
	inherits-2.0.4
	got-13.0.0
	zwave-js-14.3.6
	colorspace-1.1.4
	dns-packet-5.6.1
	cliui-8.0.1
	@types/http-cache-semantics-4.0.4
	@types/triple-beam-1.3.5
	fecha-4.2.3
	winston-3.17.0
	@zwave-js/host-14.3.4
	ansi-regex-5.0.1
	lowercase-keys-3.0.0
	object-hash-3.0.0
	require-directory-2.1.1
	stack-trace-0.0.10
	merge-stream-2.0.0
	keyv-4.5.4
	debug-4.3.4
	ms-2.1.2
	cacheable-lookup-7.0.0
	@serialport/parser-slip-encoder-12.0.0
	file-stream-rotator-0.6.1
	shebang-command-2.0.0
	ws-8.18.0
	text-hex-1.0.0
	@dabh/diagnostics-2.0.3
	form-data-encoder-2.1.4
	string_decoder-1.3.0
	mimic-response-3.1.0
	fs-extra-10.1.0
	ms-2.1.3
	@serialport/bindings-cpp-12.0.1
	color-convert-1.9.3
	@serialport/parser-byte-length-12.0.0
	isexe-2.0.0
	async-3.2.6
	fflate-0.8.2
	decompress-response-6.0.0
	@serialport/binding-mock-10.2.2
	proper-lockfile-4.1.2
	kuler-2.0.0
	y18n-5.0.8
	wrap-ansi-7.0.0
	responselike-3.0.0
	@serialport/parser-regex-12.0.0
	triple-beam-1.4.1
	simple-swizzle-0.2.2
	@leichtgewicht/ip-codec-2.0.5
	mimic-fn-2.1.0
	mdns-server-1.0.11
	ansi-colors-4.1.3
	emoji-regex-8.0.0
	signal-exit-3.0.7
	fn.name-1.1.0
	@homebridge/ciao-1.3.1
	jsonfile-6.1.0
	retry-0.12.0
	@serialport/parser-delimiter-11.0.0
	@serialport/parser-ready-12.0.0
	get-caller-file-2.0.5
	fast-deep-equal-3.1.3
	is-arrayish-0.3.2
	reflect-metadata-0.2.2
	@alcalzone/proper-lockfile-4.1.3-0
	@serialport/parser-readline-12.0.0
	normalize-url-8.0.1
	is-stream-2.0.1
	source-map-0.6.1
	strip-final-newline-2.0.0
	yargs-17.7.2
	@colors/colors-1.6.0
	@szmarczak/http-timer-5.0.1
	cross-spawn-7.0.6
	nrf-intel-hex-1.4.0
	debug-4.3.7
	@zwave-js/shared-14.3.4
	yargs-parser-21.1.1
	@zwave-js/testing-14.3.6
	p-queue-8.0.1
	readable-stream-3.6.2
	@serialport/parser-inter-byte-timeout-12.0.0
	@serialport/stream-12.0.0
	which-2.0.2
	@zwave-js/nvmedit-14.3.5
	serialport-12.0.0
	@serialport/parser-packet-length-12.0.0
	ansi-styles-4.3.0
	enabled-2.0.0
	json-buffer-3.0.1
	alcalzone-shared-5.0.0
	npm-run-path-4.0.1
	@sindresorhus/is-5.6.0
	node-gyp-build-4.6.0
	winston-transport-4.9.0
	p-timeout-6.1.3
	is-fullwidth-code-point-3.0.0
	p-cancelable-3.0.0
	color-name-1.1.3
	http-cache-semantics-4.1.1
	safe-stable-stringify-2.5.0
	color-name-1.1.4
	@serialport/parser-spacepacket-12.0.0
	http2-wrapper-2.2.1
	universalify-2.0.1
	xstate-4.38.3
	defer-to-connect-2.0.1
	color-3.2.1
	semver-7.6.3
	string-width-4.2.3
	path-key-3.1.1
	strip-ansi-6.0.1
	@zwave-js/core-14.3.4
	moment-2.30.1
	graceful-fs-4.2.11
	@serialport/parser-delimiter-12.0.0
	quick-lru-5.1.1
	safe-buffer-5.2.1
	dayjs-1.11.13
	color-convert-2.0.1
	tslib-2.8.1
	@alcalzone/jsonl-db-3.1.1
	json-logic-js-2.0.5
	get-stream-6.0.1
	@zwave-js/cc-14.3.6
	mimic-response-4.0.0
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

LICENSE="0BSD Apache-2.0 BSD BSD-2 ISC MIT"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist/bin/"{client,server}.js
	dosym "../$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist/bin/client.js" /usr/bin/zwave-client
	dosym "../$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist/bin/server.js" /usr/bin/zwave-server
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
