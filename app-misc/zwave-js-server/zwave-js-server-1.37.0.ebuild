# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@zwave-js/server-1.37.0
	moment-2.30.1
	color-name-1.1.4
	@sindresorhus/is-5.6.0
	readable-stream-3.6.2
	human-signals-2.1.0
	json5-2.2.3
	minimist-1.2.8
	@zwave-js/shared-13.0.0
	node-gyp-build-4.6.0
	shebang-command-2.0.0
	winston-transport-4.7.1
	alcalzone-shared-4.0.8
	jsonfile-6.1.0
	file-stream-rotator-0.6.1
	got-13.0.0
	string_decoder-1.3.0
	one-time-1.0.0
	y18n-5.0.8
	@serialport/parser-regex-12.0.0
	@zwave-js/testing-13.0.1
	fecha-4.2.3
	string-width-4.2.3
	colorspace-1.1.4
	winston-3.13.1
	safe-stable-stringify-2.4.3
	@zwave-js/host-13.0.1
	require-directory-2.1.1
	@szmarczak/http-timer-5.0.1
	fs-extra-10.1.0
	mime-types-2.1.35
	normalize-url-8.0.1
	color-name-1.1.3
	@serialport/binding-mock-10.2.2
	escalade-3.1.2
	json-logic-js-2.0.5
	color-convert-1.9.3
	universalify-2.0.1
	proper-lockfile-4.1.2
	tslib-2.6.3
	stack-trace-0.0.10
	decompress-response-6.0.0
	safe-buffer-5.2.1
	get-caller-file-2.0.5
	@serialport/stream-12.0.0
	enabled-2.0.0
	@serialport/parser-delimiter-12.0.0
	@serialport/parser-spacepacket-12.0.0
	cacheable-request-10.2.14
	ms-2.1.2
	triple-beam-1.4.1
	dayjs-1.11.12
	source-map-0.6.1
	@types/http-cache-semantics-4.0.4
	isexe-2.0.0
	asynckit-0.4.0
	@serialport/bindings-cpp-12.0.1
	ansi-colors-4.1.3
	http-cache-semantics-4.1.1
	graceful-fs-4.2.11
	dns-packet-5.6.1
	yargs-parser-21.1.1
	is-arrayish-0.3.2
	delayed-stream-1.0.0
	globrex-0.1.2
	which-2.0.2
	logform-2.6.1
	mime-db-1.52.0
	@serialport/parser-byte-length-12.0.0
	@serialport/parser-inter-byte-timeout-12.0.0
	nrf-intel-hex-1.4.0
	cliui-8.0.1
	ms-2.1.3
	quick-lru-5.1.1
	p-cancelable-3.0.0
	zwave-js-13.0.1
	follow-redirects-1.15.6
	ws-8.18.0
	xstate-4.38.3
	@serialport/parser-ready-12.0.0
	yargs-17.7.2
	@leichtgewicht/ip-codec-2.0.5
	@serialport/bindings-interface-1.2.2
	debug-4.3.5
	eventemitter3-5.0.1
	is-fullwidth-code-point-3.0.0
	http2-wrapper-2.2.1
	@serialport/parser-packet-length-12.0.0
	serialport-12.0.0
	signal-exit-3.0.7
	tiny-glob-0.2.9
	onetime-5.1.2
	combined-stream-1.0.8
	axios-1.7.2
	simple-swizzle-0.2.2
	mdns-server-1.0.11
	lowercase-keys-3.0.0
	inherits-2.0.4
	proxy-from-env-1.1.0
	retry-0.12.0
	path-key-3.1.1
	@serialport/parser-cctalk-12.0.0
	@zwave-js/cc-13.0.1
	async-3.2.5
	globalyzer-0.1.0
	mimic-fn-2.1.0
	ansi-regex-5.0.1
	execa-5.1.1
	json-buffer-3.0.1
	reflect-metadata-0.2.2
	object-hash-3.0.0
	@serialport/parser-slip-encoder-12.0.0
	emoji-regex-8.0.0
	buffer-from-1.1.2
	shebang-regex-3.0.0
	ansi-styles-4.3.0
	@zwave-js/serial-13.0.1
	execa-5.0.1
	util-deprecate-1.0.2
	debug-4.3.4
	text-hex-1.0.0
	@serialport/parser-readline-12.0.0
	semver-7.6.3
	p-timeout-6.1.2
	@zwave-js/nvmedit-13.0.1
	resolve-alpn-1.2.1
	fn.name-1.1.0
	strip-final-newline-2.0.0
	@serialport/parser-delimiter-11.0.0
	npm-run-path-4.0.1
	kuler-2.0.0
	cacheable-lookup-7.0.0
	@alcalzone/proper-lockfile-4.1.3-0
	@colors/colors-1.6.0
	responselike-3.0.0
	@alcalzone/jsonl-db-3.1.1
	@homebridge/ciao-1.3.0
	wrap-ansi-7.0.0
	defer-to-connect-2.0.1
	winston-daily-rotate-file-5.0.0
	get-stream-6.0.1
	mimic-response-4.0.0
	@serialport/parser-readline-11.0.0
	p-queue-8.0.1
	strip-ansi-6.0.1
	color-string-1.9.1
	color-3.2.1
	mimic-response-3.1.0
	is-stream-2.0.1
	node-addon-api-7.0.0
	keyv-4.5.4
	color-convert-2.0.1
	@zwave-js/core-13.0.1
	fast-deep-equal-3.1.3
	@dabh/diagnostics-2.0.3
	fs-extra-11.2.0
	source-map-support-0.5.21
	form-data-encoder-2.1.4
	form-data-4.0.0
	@alcalzone/pak-0.11.0
	@zwave-js/config-13.0.1
	@types/triple-beam-1.3.5
	cross-spawn-7.0.3
	merge-stream-2.0.0
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
