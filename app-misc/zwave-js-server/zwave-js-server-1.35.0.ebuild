# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.35.0
	execa-5.1.1
	mimic-response-3.1.0
	string-width-4.2.3
	form-data-4.0.0
	@alcalzone/jsonl-db-3.1.1
	@serialport/parser-delimiter-11.0.0
	semver-7.6.0
	@serialport/parser-spacepacket-12.0.0
	mdns-server-1.0.11
	emoji-regex-8.0.0
	@alcalzone/pak-0.10.2
	@serialport/bindings-cpp-12.0.1
	@serialport/parser-ready-12.0.0
	@serialport/parser-slip-encoder-12.0.0
	ansi-styles-4.3.0
	@zwave-js/host-12.5.5
	ansi-colors-4.1.3
	cacheable-lookup-7.0.0
	combined-stream-1.0.8
	mime-types-2.1.35
	strip-final-newline-2.0.0
	ms-2.1.2
	@sindresorhus/is-5.6.0
	get-caller-file-2.0.5
	@zwave-js/serial-12.5.5
	@alcalzone/proper-lockfile-4.1.3-0
	text-hex-1.0.0
	defer-to-connect-2.0.1
	@serialport/stream-12.0.0
	@types/triple-beam-1.3.5
	yargs-17.7.2
	y18n-5.0.8
	@zwave-js/shared-12.5.3
	mimic-response-4.0.0
	@szmarczak/http-timer-5.0.1
	universalify-2.0.1
	@types/http-cache-semantics-4.0.4
	merge-stream-2.0.0
	util-deprecate-1.0.2
	globalyzer-0.1.0
	@zwave-js/config-12.5.5
	@serialport/parser-packet-length-12.0.0
	safe-buffer-5.2.1
	p-cancelable-3.0.0
	fs-extra-10.1.0
	color-name-1.1.3
	mimic-fn-2.1.0
	retry-0.12.0
	@zwave-js/testing-12.5.5
	cacheable-request-10.2.14
	source-map-0.6.1
	keyv-4.5.4
	fn.name-1.1.0
	stack-trace-0.0.10
	string_decoder-1.3.0
	ms-2.1.3
	source-map-support-0.5.21
	globrex-0.1.2
	alcalzone-shared-4.0.8
	buffer-from-1.1.2
	is-fullwidth-code-point-3.0.0
	is-arrayish-0.3.2
	onetime-5.1.2
	asynckit-0.4.0
	winston-transport-4.7.0
	delayed-stream-1.0.0
	execa-5.0.1
	is-stream-2.0.1
	@colors/colors-1.6.0
	http2-wrapper-2.2.1
	form-data-encoder-2.1.4
	readable-stream-3.6.2
	colorspace-1.1.4
	enabled-2.0.0
	get-stream-6.0.1
	one-time-1.0.0
	triple-beam-1.4.1
	zwave-js-12.5.5
	inherits-2.0.4
	isexe-2.0.0
	file-stream-rotator-0.6.1
	cliui-8.0.1
	@serialport/parser-readline-11.0.0
	ansi-regex-5.0.1
	ws-8.16.0
	@zwave-js/cc-12.5.5
	json5-2.2.3
	follow-redirects-1.15.6
	node-gyp-build-4.6.0
	npm-run-path-4.0.1
	@dabh/diagnostics-2.0.3
	nrf-intel-hex-1.4.0
	@leichtgewicht/ip-codec-2.0.5
	kuler-2.0.0
	reflect-metadata-0.2.2
	serialport-12.0.0
	json-buffer-3.0.1
	shebang-command-2.0.0
	xstate-4.38.3
	@serialport/parser-byte-length-12.0.0
	@serialport/bindings-interface-1.2.2
	@zwave-js/nvmedit-12.5.5
	node-addon-api-7.0.0
	logform-2.6.0
	http-cache-semantics-4.1.1
	@homebridge/ciao-1.2.0
	got-13.0.0
	dns-packet-5.6.1
	fast-deep-equal-3.1.3
	json-logic-js-2.0.2
	p-queue-7.4.1
	fs-extra-11.2.0
	color-convert-1.9.3
	eventemitter3-5.0.1
	@serialport/parser-cctalk-12.0.0
	yargs-parser-21.1.1
	minimist-1.2.8
	color-name-1.1.4
	@serialport/parser-inter-byte-timeout-12.0.0
	axios-1.6.8
	color-string-1.9.1
	simple-swizzle-0.2.2
	dayjs-1.11.10
	fecha-4.2.3
	resolve-alpn-1.2.1
	yallist-4.0.0
	wrap-ansi-7.0.0
	mime-db-1.52.0
	cross-spawn-7.0.3
	proxy-from-env-1.1.0
	winston-daily-rotate-file-5.0.0
	which-2.0.2
	lowercase-keys-3.0.0
	object-hash-3.0.0
	escalade-3.1.2
	human-signals-2.1.0
	shebang-regex-3.0.0
	@serialport/parser-delimiter-12.0.0
	tslib-2.6.2
	proper-lockfile-4.1.2
	winston-3.13.0
	decompress-response-6.0.0
	graceful-fs-4.2.11
	responselike-3.0.0
	jsonfile-6.1.0
	strip-ansi-6.0.1
	@serialport/binding-mock-10.2.2
	color-convert-2.0.1
	signal-exit-3.0.7
	color-3.2.1
	debug-4.3.4
	@serialport/parser-readline-12.0.0
	@zwave-js/core-12.5.3
	moment-2.30.1
	require-directory-2.1.1
	p-timeout-5.1.0
	async-3.2.5
	safe-stable-stringify-2.4.3
	quick-lru-5.1.1
	path-key-3.1.1
	lru-cache-6.0.0
	tiny-glob-0.2.9
	normalize-url-8.0.1
	@serialport/parser-regex-12.0.0
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
