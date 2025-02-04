# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.40.3
	safe-buffer-5.2.1
	alcalzone-shared-5.0.0
	@zwave-js/serial-14.3.8
	reflect-metadata-0.2.2
	got-13.0.0
	nrf-intel-hex-1.4.0
	winston-transport-4.9.0
	buffer-from-1.1.2
	triple-beam-1.4.1
	mdns-server-1.0.11
	winston-3.17.0
	shebang-command-2.0.0
	logform-2.7.0
	@serialport/parser-slip-encoder-12.0.0
	cross-spawn-7.0.6
	escalade-3.2.0
	color-string-1.9.1
	color-name-1.1.4
	winston-daily-rotate-file-5.0.0
	is-stream-2.0.1
	readable-stream-3.6.2
	enabled-2.0.0
	quick-lru-5.1.1
	@szmarczak/http-timer-5.0.1
	p-timeout-6.1.4
	string-width-4.2.3
	defer-to-connect-2.0.1
	npm-run-path-4.0.1
	y18n-5.0.8
	source-map-0.6.1
	@zwave-js/config-14.3.8
	serialport-12.0.0
	fn.name-1.1.0
	strip-ansi-6.0.1
	simple-swizzle-0.2.2
	isexe-2.0.0
	fs-extra-10.1.0
	p-queue-8.1.0
	execa-5.1.1
	mimic-response-4.0.0
	jsonfile-6.1.0
	@zwave-js/host-14.3.8
	@serialport/bindings-cpp-12.0.1
	color-name-1.1.3
	decompress-response-6.0.0
	graceful-fs-4.2.11
	signal-exit-3.0.7
	universalify-2.0.1
	alcalzone-shared-4.0.8
	form-data-encoder-2.1.4
	util-deprecate-1.0.2
	stack-trace-0.0.10
	p-cancelable-3.0.0
	file-stream-rotator-0.6.1
	@zwave-js/core-14.3.8
	@serialport/parser-readline-12.0.0
	@leichtgewicht/ip-codec-2.0.5
	responselike-3.0.0
	zwave-js-14.3.8
	normalize-url-8.0.1
	cacheable-request-10.2.14
	@zwave-js/shared-14.3.7
	@colors/colors-1.6.0
	ms-2.1.2
	tslib-2.8.1
	lowercase-keys-3.0.0
	wrap-ansi-7.0.0
	@serialport/parser-inter-byte-timeout-12.0.0
	@types/http-cache-semantics-4.0.4
	fast-deep-equal-3.1.3
	mimic-fn-2.1.0
	@serialport/parser-delimiter-12.0.0
	semver-7.7.1
	@alcalzone/proper-lockfile-4.1.3-0
	cacheable-lookup-7.0.0
	node-addon-api-7.0.0
	@homebridge/ciao-1.3.1
	color-convert-1.9.3
	emoji-regex-8.0.0
	@serialport/parser-regex-12.0.0
	dns-packet-5.6.1
	require-directory-2.1.1
	@serialport/parser-readline-11.0.0
	@sindresorhus/is-5.6.0
	yargs-17.7.2
	@serialport/parser-delimiter-11.0.0
	async-3.2.6
	json-buffer-3.0.1
	is-fullwidth-code-point-3.0.0
	@zwave-js/cc-14.3.8
	inherits-2.0.4
	dayjs-1.11.13
	node-gyp-build-4.6.0
	@types/triple-beam-1.3.5
	@zwave-js/nvmedit-14.3.8
	strip-final-newline-2.0.0
	@serialport/binding-mock-10.2.2
	@serialport/bindings-interface-1.2.2
	@serialport/parser-packet-length-12.0.0
	@alcalzone/jsonl-db-3.1.1
	text-hex-1.0.0
	fflate-0.8.2
	debug-4.4.0
	minimist-1.2.8
	mimic-response-3.1.0
	color-convert-2.0.1
	eventemitter3-5.0.1
	@serialport/parser-spacepacket-12.0.0
	@zwave-js/testing-14.3.8
	moment-2.30.1
	ws-8.18.0
	http-cache-semantics-4.1.1
	proper-lockfile-4.1.2
	get-caller-file-2.0.5
	@serialport/stream-12.0.0
	kuler-2.0.0
	merge-stream-2.0.0
	@serialport/parser-byte-length-12.0.0
	ms-2.1.3
	path-key-3.1.1
	keyv-4.5.4
	@dabh/diagnostics-2.0.3
	safe-stable-stringify-2.5.0
	one-time-1.0.0
	ansi-regex-5.0.1
	shebang-regex-3.0.0
	ansi-colors-4.1.3
	resolve-alpn-1.2.1
	color-3.2.1
	which-2.0.2
	@serialport/parser-ready-12.0.0
	json-logic-js-2.0.5
	onetime-5.1.2
	cliui-8.0.1
	yargs-parser-21.1.1
	retry-0.12.0
	string_decoder-1.3.0
	xstate-4.38.3
	colorspace-1.1.4
	object-hash-3.0.0
	ansi-styles-4.3.0
	json5-2.2.3
	@serialport/parser-cctalk-12.0.0
	is-arrayish-0.3.2
	human-signals-2.1.0
	source-map-support-0.5.21
	get-stream-6.0.1
	debug-4.3.4
	http2-wrapper-2.2.1
	fecha-4.2.3
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
