# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.40.0
	nrf-intel-hex-1.4.0
	async-3.2.6
	serialport-12.0.0
	color-convert-2.0.1
	alcalzone-shared-4.0.8
	dns-packet-5.6.1
	@homebridge/ciao-1.3.1
	buffer-from-1.1.2
	is-arrayish-0.3.2
	winston-transport-4.9.0
	@serialport/parser-readline-11.0.0
	get-stream-6.0.1
	color-convert-1.9.3
	color-3.2.1
	@zwave-js/cc-14.3.3
	color-name-1.1.3
	mdns-server-1.0.11
	is-stream-2.0.1
	graceful-fs-4.2.11
	json-buffer-3.0.1
	json5-2.2.3
	@serialport/parser-cctalk-12.0.0
	ansi-styles-4.3.0
	strip-final-newline-2.0.0
	@serialport/stream-12.0.0
	@serialport/parser-packet-length-12.0.0
	npm-run-path-4.0.1
	color-name-1.1.4
	@types/triple-beam-1.3.5
	reflect-metadata-0.2.2
	universalify-2.0.1
	alcalzone-shared-5.0.0
	@serialport/parser-delimiter-12.0.0
	source-map-support-0.5.21
	defer-to-connect-2.0.1
	emoji-regex-8.0.0
	fast-deep-equal-3.1.3
	which-2.0.2
	normalize-url-8.0.1
	@alcalzone/proper-lockfile-4.1.3-0
	zwave-js-14.3.3
	form-data-encoder-2.1.4
	node-addon-api-7.0.0
	string-width-4.2.3
	human-signals-2.1.0
	enabled-2.0.0
	http-cache-semantics-4.1.1
	logform-2.7.0
	mimic-response-4.0.0
	node-gyp-build-4.6.0
	one-time-1.0.0
	eventemitter3-5.0.1
	responselike-3.0.0
	p-cancelable-3.0.0
	winston-3.17.0
	cacheable-request-10.2.14
	cliui-8.0.1
	kuler-2.0.0
	execa-5.1.1
	ansi-regex-5.0.1
	merge-stream-2.0.0
	onetime-5.1.2
	debug-4.3.7
	quick-lru-5.1.1
	@serialport/parser-readline-12.0.0
	inherits-2.0.4
	wrap-ansi-7.0.0
	colorspace-1.1.4
	resolve-alpn-1.2.1
	color-string-1.9.1
	util-deprecate-1.0.2
	xstate-4.38.3
	@zwave-js/core-14.3.3
	@zwave-js/shared-14.3.2
	@alcalzone/jsonl-db-3.1.1
	fecha-4.2.3
	path-key-3.1.1
	json-logic-js-2.0.5
	@zwave-js/config-14.3.3
	get-caller-file-2.0.5
	y18n-5.0.8
	dayjs-1.11.13
	@serialport/binding-mock-10.2.2
	@serialport/bindings-cpp-12.0.1
	@zwave-js/nvmedit-14.3.3
	tslib-2.8.1
	moment-2.30.1
	jsonfile-6.1.0
	escalade-3.2.0
	ws-8.18.0
	safe-buffer-5.2.1
	is-fullwidth-code-point-3.0.0
	source-map-0.6.1
	@serialport/parser-byte-length-12.0.0
	ansi-colors-4.1.3
	file-stream-rotator-0.6.1
	@zwave-js/testing-14.3.3
	@serialport/parser-ready-12.0.0
	winston-daily-rotate-file-5.0.0
	triple-beam-1.4.1
	fn.name-1.1.0
	readable-stream-3.6.2
	semver-7.6.3
	@zwave-js/host-14.3.3
	@serialport/parser-slip-encoder-12.0.0
	@szmarczak/http-timer-5.0.1
	@zwave-js/serial-14.3.3
	require-directory-2.1.1
	shebang-command-2.0.0
	p-timeout-6.1.3
	mimic-fn-2.1.0
	signal-exit-3.0.7
	mimic-response-3.1.0
	got-13.0.0
	@serialport/parser-inter-byte-timeout-12.0.0
	cross-spawn-7.0.5
	cacheable-lookup-7.0.0
	p-queue-8.0.1
	@serialport/parser-delimiter-11.0.0
	string_decoder-1.3.0
	@colors/colors-1.6.0
	@leichtgewicht/ip-codec-2.0.5
	@serialport/bindings-interface-1.2.2
	keyv-4.5.4
	fflate-0.8.2
	shebang-regex-3.0.0
	simple-swizzle-0.2.2
	stack-trace-0.0.10
	decompress-response-6.0.0
	@types/http-cache-semantics-4.0.4
	ms-2.1.2
	http2-wrapper-2.2.1
	text-hex-1.0.0
	yargs-parser-21.1.1
	object-hash-3.0.0
	ms-2.1.3
	isexe-2.0.0
	proper-lockfile-4.1.2
	safe-stable-stringify-2.5.0
	strip-ansi-6.0.1
	@serialport/parser-regex-12.0.0
	@serialport/parser-spacepacket-12.0.0
	@dabh/diagnostics-2.0.3
	lowercase-keys-3.0.0
	yargs-17.7.2
	@sindresorhus/is-5.6.0
	retry-0.12.0
	minimist-1.2.8
	fs-extra-10.1.0
	debug-4.3.4
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
