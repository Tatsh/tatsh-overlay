# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.36.0
	mime-db-1.52.0
	y18n-5.0.8
	object-hash-3.0.0
	dayjs-1.11.11
	zwave-js-12.11.0
	http2-wrapper-2.2.1
	@colors/colors-1.6.0
	proper-lockfile-4.1.2
	resolve-alpn-1.2.1
	path-key-3.1.1
	decompress-response-6.0.0
	globrex-0.1.2
	color-3.2.1
	debug-4.3.4
	@zwave-js/config-12.11.0
	fs-extra-11.2.0
	http-cache-semantics-4.1.1
	p-timeout-5.1.0
	ansi-colors-4.1.3
	color-name-1.1.4
	ms-2.1.3
	@types/http-cache-semantics-4.0.4
	xstate-4.38.3
	get-stream-6.0.1
	normalize-url-8.0.1
	require-directory-2.1.1
	@serialport/bindings-interface-1.2.2
	jsonfile-6.1.0
	@serialport/parser-regex-12.0.0
	async-3.2.5
	execa-5.0.1
	winston-3.13.0
	@alcalzone/proper-lockfile-4.1.3-0
	@leichtgewicht/ip-codec-2.0.5
	cacheable-lookup-7.0.0
	debug-4.3.5
	onetime-5.1.2
	p-cancelable-3.0.0
	wrap-ansi-7.0.0
	stack-trace-0.0.10
	@zwave-js/nvmedit-12.11.0
	file-stream-rotator-0.6.1
	@serialport/stream-12.0.0
	defer-to-connect-2.0.1
	moment-2.30.1
	graceful-fs-4.2.11
	@serialport/parser-delimiter-12.0.0
	@serialport/parser-packet-length-12.0.0
	eventemitter3-5.0.1
	@zwave-js/host-12.11.0
	follow-redirects-1.15.6
	@serialport/parser-readline-12.0.0
	is-fullwidth-code-point-3.0.0
	ws-8.17.1
	globalyzer-0.1.0
	@serialport/parser-readline-11.0.0
	color-convert-2.0.1
	asynckit-0.4.0
	tslib-2.6.3
	source-map-support-0.5.21
	color-name-1.1.3
	fn.name-1.1.0
	lowercase-keys-3.0.0
	semver-7.6.2
	cross-spawn-7.0.3
	mimic-fn-2.1.0
	@serialport/parser-inter-byte-timeout-12.0.0
	is-stream-2.0.1
	mimic-response-3.1.0
	triple-beam-1.4.1
	cliui-8.0.1
	ansi-regex-5.0.1
	serialport-12.0.0
	tiny-glob-0.2.9
	alcalzone-shared-4.0.8
	logform-2.6.0
	ms-2.1.2
	p-queue-7.4.1
	human-signals-2.1.0
	yargs-parser-21.1.1
	util-deprecate-1.0.2
	simple-swizzle-0.2.2
	delayed-stream-1.0.0
	form-data-encoder-2.1.4
	one-time-1.0.0
	isexe-2.0.0
	dns-packet-5.6.1
	strip-final-newline-2.0.0
	@zwave-js/testing-12.11.0
	keyv-4.5.4
	@serialport/parser-byte-length-12.0.0
	@alcalzone/jsonl-db-3.1.1
	json5-2.2.3
	@zwave-js/core-12.11.0
	strip-ansi-6.0.1
	node-addon-api-7.0.0
	retry-0.12.0
	proxy-from-env-1.1.0
	@serialport/parser-cctalk-12.0.0
	mimic-response-4.0.0
	responselike-3.0.0
	string-width-4.2.3
	colorspace-1.1.4
	@dabh/diagnostics-2.0.3
	got-13.0.0
	emoji-regex-8.0.0
	@homebridge/ciao-1.2.0
	@serialport/binding-mock-10.2.2
	execa-5.1.1
	signal-exit-3.0.7
	readable-stream-3.6.2
	safe-stable-stringify-2.4.3
	fast-deep-equal-3.1.3
	@sindresorhus/is-5.6.0
	@serialport/parser-ready-12.0.0
	combined-stream-1.0.8
	fecha-4.2.3
	quick-lru-5.1.1
	shebang-regex-3.0.0
	is-arrayish-0.3.2
	merge-stream-2.0.0
	safe-buffer-5.2.1
	source-map-0.6.1
	minimist-1.2.8
	enabled-2.0.0
	universalify-2.0.1
	winston-transport-4.7.0
	nrf-intel-hex-1.4.0
	json-logic-js-2.0.2
	@zwave-js/cc-12.11.0
	@serialport/parser-delimiter-11.0.0
	@szmarczak/http-timer-5.0.1
	@serialport/parser-spacepacket-12.0.0
	@alcalzone/pak-0.10.2
	escalade-3.1.2
	kuler-2.0.0
	inherits-2.0.4
	@serialport/parser-slip-encoder-12.0.0
	color-convert-1.9.3
	winston-daily-rotate-file-5.0.0
	reflect-metadata-0.2.2
	ansi-styles-4.3.0
	buffer-from-1.1.2
	npm-run-path-4.0.1
	which-2.0.2
	@types/triple-beam-1.3.5
	mime-types-2.1.35
	axios-1.7.2
	form-data-4.0.0
	cacheable-request-10.2.14
	yargs-17.7.2
	@serialport/bindings-cpp-12.0.1
	get-caller-file-2.0.5
	mdns-server-1.0.11
	@zwave-js/shared-12.5.3
	node-gyp-build-4.6.0
	color-string-1.9.1
	json-buffer-3.0.1
	shebang-command-2.0.0
	@zwave-js/serial-12.11.0
	text-hex-1.0.0
	fs-extra-10.1.0
	string_decoder-1.3.0
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
