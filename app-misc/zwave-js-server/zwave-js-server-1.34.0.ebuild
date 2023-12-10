# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.34.0
	globalyzer-0.1.0
	emoji-regex-8.0.0
	mime-db-1.52.0
	signal-exit-3.0.7
	@types/http-cache-semantics-4.0.4
	@serialport/parser-regex-12.0.0
	@serialport/bindings-cpp-12.0.1
	@serialport/parser-inter-byte-timeout-12.0.0
	@zwave-js/cc-12.4.1
	@serialport/parser-slip-encoder-12.0.0
	execa-5.0.1
	json-logic-js-2.0.2
	text-hex-1.0.0
	color-name-1.1.4
	@serialport/parser-readline-11.0.0
	ansi-regex-5.0.1
	fecha-4.2.3
	lru-cache-6.0.0
	is-fullwidth-code-point-3.0.0
	lowercase-keys-3.0.0
	@dabh/diagnostics-2.0.3
	form-data-4.0.0
	y18n-5.0.8
	fn.name-1.1.0
	winston-transport-4.6.0
	@alcalzone/pak-0.10.1
	globrex-0.1.2
	p-cancelable-3.0.0
	normalize-url-8.0.0
	mimic-response-4.0.0
	combined-stream-1.0.8
	@zwave-js/shared-12.2.3
	shebang-command-2.0.0
	@alcalzone/jsonl-db-3.1.0
	xstate-4.38.2
	one-time-1.0.0
	proxy-from-env-1.1.0
	fs-extra-10.1.0
	@serialport/parser-cctalk-12.0.0
	decompress-response-6.0.0
	@serialport/binding-mock-10.2.2
	@types/triple-beam-1.3.5
	mimic-fn-2.1.0
	merge-stream-2.0.0
	kuler-2.0.0
	yallist-4.0.0
	@zwave-js/serial-12.4.1
	execa-5.1.1
	@alcalzone/proper-lockfile-4.1.3-0
	delayed-stream-1.0.0
	@serialport/parser-readline-12.0.0
	jsonfile-6.1.0
	@zwave-js/host-12.4.1
	eventemitter3-5.0.1
	human-signals-2.1.0
	dns-packet-5.6.1
	@sindresorhus/is-5.6.0
	safe-buffer-5.2.1
	minimist-1.2.8
	@zwave-js/core-12.4.0
	escalade-3.1.1
	shebang-regex-3.0.0
	async-3.2.5
	@szmarczak/http-timer-5.0.1
	mime-types-2.1.35
	cliui-8.0.1
	serialport-12.0.0
	yargs-17.7.2
	reflect-metadata-0.1.14
	ansi-colors-4.1.3
	@zwave-js/nvmedit-12.4.0
	ws-8.15.0
	@leichtgewicht/ip-codec-2.0.4
	zwave-js-12.4.1
	http-cache-semantics-4.1.1
	safe-stable-stringify-2.4.3
	nrf-intel-hex-1.4.0
	fast-deep-equal-3.1.3
	mimic-response-3.1.0
	moment-2.29.4
	@serialport/stream-12.0.0
	axios-1.6.2
	path-key-3.1.1
	stack-trace-0.0.10
	cross-spawn-7.0.3
	@serialport/parser-byte-length-12.0.0
	get-caller-file-2.0.5
	string-width-4.2.3
	debug-4.3.4
	strip-final-newline-2.0.0
	buffer-from-1.1.2
	is-stream-2.0.1
	winston-daily-rotate-file-4.7.1
	simple-swizzle-0.2.2
	resolve-alpn-1.2.1
	quick-lru-5.1.1
	responselike-3.0.0
	universalify-2.0.1
	string_decoder-1.3.0
	got-13.0.0
	@serialport/parser-ready-12.0.0
	is-arrayish-0.3.2
	@serialport/parser-packet-length-12.0.0
	json5-2.2.3
	node-gyp-build-4.6.0
	follow-redirects-1.15.3
	require-directory-2.1.1
	dayjs-1.11.10
	source-map-0.6.1
	@homebridge/ciao-1.1.8
	cacheable-lookup-7.0.0
	ms-2.1.3
	color-name-1.1.3
	node-addon-api-7.0.0
	triple-beam-1.4.1
	@zwave-js/testing-12.4.1
	object-hash-2.2.0
	@serialport/parser-spacepacket-12.0.0
	logform-2.6.0
	proper-lockfile-4.1.2
	defer-to-connect-2.0.1
	@serialport/parser-delimiter-11.0.0
	color-3.2.1
	p-timeout-5.1.0
	wrap-ansi-7.0.0
	asynckit-0.4.0
	source-map-support-0.5.21
	fs-extra-11.2.0
	tslib-2.6.2
	ansi-styles-4.3.0
	isexe-2.0.0
	keyv-4.5.4
	winston-3.11.0
	@serialport/bindings-interface-1.2.2
	get-stream-6.0.1
	http2-wrapper-2.2.1
	alcalzone-shared-4.0.8
	cacheable-request-10.2.14
	color-convert-1.9.3
	mdns-server-1.0.11
	semver-7.5.4
	yargs-parser-21.1.1
	color-convert-2.0.1
	retry-0.12.0
	@zwave-js/config-12.4.1
	readable-stream-3.6.2
	@colors/colors-1.6.0
	@serialport/parser-delimiter-12.0.0
	form-data-encoder-2.1.4
	inherits-2.0.4
	onetime-5.1.2
	json-buffer-3.0.1
	p-queue-7.4.1
	tiny-glob-0.2.9
	enabled-2.0.0
	file-stream-rotator-0.6.1
	ms-2.1.2
	which-2.0.2
	strip-ansi-6.0.1
	graceful-fs-4.2.11
	colorspace-1.1.4
	npm-run-path-4.0.1
	util-deprecate-1.0.2
	color-string-1.9.1
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
