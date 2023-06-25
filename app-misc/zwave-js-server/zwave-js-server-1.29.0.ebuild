# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd yarn

DESCRIPTION="Full access to zwave-js driver through Websockets"
HOMEPAGE="https://github.com/zwave-js/zwave-js-server#readme"
YARN_PKGS=(
	@zwave-js/server-${PV}
	@alcalzone/jsonl-db-3.1.0
	@alcalzone/pak-0.9.0
	@alcalzone/proper-lockfile-4.1.3-0
	@colors/colors-1.5.0
	@dabh/diagnostics-2.0.3
	@esm2cjs/cacheable-lookup-7.0.0
	@esm2cjs/cacheable-request-10.2.1
	@esm2cjs/form-data-encoder-2.1.3
	@esm2cjs/got-12.5.3
	@esm2cjs/http-timer-5.0.1
	@esm2cjs/is-5.3.0
	@esm2cjs/lowercase-keys-3.0.0
	@esm2cjs/mimic-response-4.0.0
	@esm2cjs/normalize-url-7.2.0
	@esm2cjs/p-cancelable-3.0.0
	@esm2cjs/p-queue-7.3.0
	@esm2cjs/p-timeout-5.1.0
	@esm2cjs/responselike-3.0.0
	@homebridge/ciao-1.1.4
	@leichtgewicht/ip-codec-2.0.4
	@sentry/core-7.14.2
	@sentry/hub-7.14.2
	@sentry/integrations-7.14.2
	@sentry/node-7.14.2
	@sentry/types-7.14.2
	@sentry/utils-7.14.2
	@serialport/binding-mock-10.2.2
	@serialport/bindings-cpp-10.7.0
	@serialport/bindings-interface-1.2.1
	@serialport/bindings-interface-1.2.2
	@serialport/parser-byte-length-10.3.0
	@serialport/parser-cctalk-10.3.0
	@serialport/parser-delimiter-10.3.0
	@serialport/parser-inter-byte-timeout-10.3.0
	@serialport/parser-packet-length-10.3.0
	@serialport/parser-readline-10.3.0
	@serialport/parser-ready-10.3.0
	@serialport/parser-regex-10.3.0
	@serialport/parser-slip-encoder-10.3.0
	@serialport/parser-spacepacket-10.3.0
	@serialport/stream-10.3.0
	@types/http-cache-semantics-4.0.1
	@types/triple-beam-1.3.2
	@zwave-js/cc-11.0.0
	@zwave-js/config-11.0.0
	@zwave-js/core-11.0.0
	@zwave-js/host-11.0.0
	@zwave-js/nvmedit-11.0.0
	@zwave-js/serial-11.0.0
	@zwave-js/shared-11.0.0
	@zwave-js/testing-11.0.0
	agent-base-6.0.2
	alcalzone-shared-4.0.8
	ansi-colors-4.1.3
	ansi-regex-5.0.1
	ansi-styles-4.3.0
	async-3.2.4
	asynckit-0.4.0
	axios-0.27.2
	buffer-from-1.1.2
	cliui-8.0.1
	color-3.2.1
	color-convert-1.9.3
	color-convert-2.0.1
	color-name-1.1.3
	color-name-1.1.4
	color-string-1.9.1
	colorspace-1.1.4
	combined-stream-1.0.8
	cookie-0.4.2
	cross-spawn-7.0.3
	dayjs-1.11.8
	debug-4.3.4
	decompress-response-6.0.0
	defer-to-connect-2.0.1
	delayed-stream-1.0.0
	dns-packet-5.6.0
	emoji-regex-8.0.0
	enabled-2.0.0
	escalade-3.1.1
	eventemitter3-4.0.7
	execa-5.0.1
	execa-5.1.1
	fast-deep-equal-3.1.3
	fecha-4.2.3
	file-stream-rotator-0.6.1
	fn.name-1.1.0
	follow-redirects-1.15.2
	form-data-4.0.0
	fs-extra-10.1.0
	get-caller-file-2.0.5
	get-stream-6.0.1
	globalyzer-0.1.0
	globrex-0.1.2
	graceful-fs-4.2.10
	http-cache-semantics-4.1.0
	http2-wrapper-2.1.11
	https-proxy-agent-5.0.1
	human-signals-2.1.0
	immediate-3.0.6
	inherits-2.0.4
	is-arrayish-0.3.2
	is-fullwidth-code-point-3.0.0
	is-stream-2.0.1
	isexe-2.0.0
	json-buffer-3.0.1
	json-logic-js-2.0.2
	json5-2.2.3
	jsonfile-6.1.0
	keyv-4.5.0
	kuler-2.0.0
	lie-3.1.1
	localforage-1.10.0
	logform-2.4.2
	logform-2.5.1
	lowercase-keys-3.0.0
	lru-cache-6.0.0
	lru_map-0.3.3
	mdns-server-1.0.11
	merge-stream-2.0.0
	mime-db-1.52.0
	mime-types-2.1.35
	mimic-fn-2.1.0
	mimic-response-3.1.0
	minimist-1.2.6
	moment-2.29.4
	ms-2.1.2
	ms-2.1.3
	node-addon-api-4.3.0
	node-gyp-build-4.5.0
	npm-run-path-4.0.1
	nrf-intel-hex-1.3.0
	object-hash-2.2.0
	one-time-1.0.0
	onetime-5.1.2
	path-key-3.1.1
	proper-lockfile-4.1.2
	quick-lru-5.1.1
	readable-stream-3.6.0
	reflect-metadata-0.1.13
	require-directory-2.1.1
	resolve-alpn-1.2.1
	responselike-3.0.0
	retry-0.12.0
	safe-buffer-5.2.1
	safe-stable-stringify-2.4.0
	semver-7.3.8
	semver-7.5.3
	serialport-10.4.0
	shebang-command-2.0.0
	shebang-regex-3.0.0
	signal-exit-3.0.7
	simple-swizzle-0.2.2
	source-map-0.6.1
	source-map-support-0.5.21
	stack-trace-0.0.10
	string-width-4.2.3
	string_decoder-1.3.0
	strip-ansi-6.0.1
	strip-final-newline-2.0.0
	text-hex-1.0.0
	tiny-glob-0.2.9
	triple-beam-1.3.0
	tslib-1.14.1
	tslib-2.4.0
	universalify-2.0.0
	util-deprecate-1.0.2
	which-2.0.2
	winston-3.8.2
	winston-daily-rotate-file-4.7.1
	winston-transport-4.5.0
	wrap-ansi-7.0.0
	ws-8.6.0
	xstate-4.29.0
	y18n-5.0.8
	yallist-4.0.0
	yargs-17.7.2
	yargs-parser-21.1.1
	zwave-js-11.0.0
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
