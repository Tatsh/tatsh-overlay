# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_GYP=1
inherit systemd yarn

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
YARN_PKGS=(
	@alcalzone/jsonl-db-4.0.2
	@alcalzone/proper-lockfile-4.1.3-0
	@andrewbranch/untar.js-1.0.3
	@colors/colors-1.6.0
	@dabh/diagnostics-2.0.8
	@eslint-community/eslint-utils-4.9.0
	@eslint-community/regexpp-4.12.2
	@eslint/config-array-0.21.1
	@eslint/config-helpers-0.4.1
	@eslint/core-0.16.0
	@eslint/eslintrc-3.3.1
	@eslint/js-9.38.0
	@eslint/object-schema-2.1.7
	@eslint/plugin-kit-0.4.0
	@homebridge/ciao-1.3.4
	@humanfs/core-0.19.1
	@humanfs/node-0.16.7
	@humanwhocodes/module-importer-1.0.1
	@humanwhocodes/retry-0.4.3
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
	@so-ric/colorspace-1.1.6
	@types/estree-1.0.8
	@types/json-schema-7.0.15
	@types/triple-beam-1.3.5
	@zwave-js/cc-15.15.3
	@zwave-js/config-15.15.3
	@zwave-js/core-15.15.3
	@zwave-js/host-15.15.3
	@zwave-js/nvmedit-15.15.3
	@zwave-js/serial-15.15.3
	@zwave-js/server-3.4.0
	@zwave-js/shared-15.15.1
	@zwave-js/testing-15.15.3
	@zwave-js/waddle-1.2.1
	acorn-8.15.0
	acorn-jsx-5.3.2
	ajv-6.12.6
	alcalzone-shared-5.0.0
	ansi-colors-4.1.3
	ansi-regex-6.2.2
	ansi-styles-4.3.0
	ansi-styles-6.2.3
	argparse-2.0.1
	async-3.2.6
	balanced-match-1.0.2
	brace-expansion-1.1.12
	buffer-from-1.1.2
	callsites-3.1.0
	chalk-4.1.2
	cliui-9.0.1
	color-5.0.2
	color-convert-2.0.1
	color-convert-3.1.2
	color-name-1.1.4
	color-name-2.0.2
	color-string-2.1.2
	concat-map-0.0.1
	cross-spawn-7.0.6
	dayjs-1.11.18
	debug-4.4.0
	debug-4.4.3
	deep-is-0.1.4
	dns-packet-5.6.1
	emoji-regex-10.6.0
	enabled-2.0.0
	escalade-3.2.0
	escape-string-regexp-4.0.0
	eslint-9.38.0
	eslint-scope-8.4.0
	eslint-visitor-keys-3.4.3
	eslint-visitor-keys-4.2.1
	espree-10.4.0
	esquery-1.6.0
	esrecurse-4.3.0
	estraverse-5.3.0
	esutils-2.0.3
	eventemitter3-5.0.1
	fast-deep-equal-3.1.3
	fast-json-stable-stringify-2.1.0
	fast-levenshtein-2.0.6
	fecha-4.2.3
	fflate-0.8.2
	file-entry-cache-8.0.0
	file-stream-rotator-0.6.1
	find-up-5.0.0
	flat-cache-4.0.1
	flatted-3.3.3
	fn.name-1.1.0
	get-caller-file-2.0.5
	get-east-asian-width-1.4.0
	glob-parent-6.0.2
	globals-14.0.0
	graceful-fs-4.2.11
	has-flag-4.0.0
	ignore-5.3.2
	import-fresh-3.3.1
	imurmurhash-0.1.4
	inherits-2.0.4
	is-extglob-2.1.1
	is-glob-4.0.3
	is-stream-2.0.1
	isexe-2.0.0
	js-yaml-4.1.0
	json-buffer-3.0.1
	json-logic-js-2.0.5
	json-schema-traverse-0.4.1
	json-stable-stringify-without-jsonify-1.0.1
	json5-2.2.3
	keyv-4.5.4
	kuler-2.0.0
	ky-1.13.0
	levn-0.4.1
	locate-path-6.0.0
	lodash.merge-4.6.2
	logform-2.7.0
	mdns-server-1.0.11
	minimatch-3.1.2
	minimist-1.2.8
	moment-2.30.1
	ms-2.1.3
	natural-compare-1.4.0
	node-addon-api-8.3.0
	node-gyp-build-4.8.4
	nrf-intel-hex-1.4.0
	object-hash-3.0.0
	one-time-1.0.0
	optionator-0.9.4
	p-limit-3.1.0
	p-locate-5.0.0
	p-queue-8.1.1
	p-timeout-6.1.4
	parent-module-1.0.1
	path-exists-4.0.0
	path-key-3.1.1
	pathe-2.0.3
	prelude-ls-1.2.1
	punycode-2.3.1
	readable-stream-3.6.2
	reflect-metadata-0.2.2
	resolve-from-4.0.0
	retry-0.12.0
	safe-buffer-5.2.1
	safe-stable-stringify-2.5.0
	semver-7.7.3
	serialport-13.0.0
	shebang-command-2.0.0
	shebang-regex-3.0.0
	signal-exit-3.0.7
	source-map-0.6.1
	source-map-support-0.5.21
	stack-trace-0.0.10
	string-width-7.2.0
	string_decoder-1.3.0
	strip-ansi-7.1.2
	strip-json-comments-3.1.1
	supports-color-7.2.0
	text-hex-1.0.0
	triple-beam-1.4.1
	tslib-2.8.1
	type-check-0.4.0
	uri-js-4.4.1
	util-deprecate-1.0.2
	which-2.0.2
	winston-3.18.3
	winston-daily-rotate-file-5.0.0
	winston-transport-4.9.0
	word-wrap-1.2.5
	wrap-ansi-9.0.2
	ws-8.18.3
	y18n-5.0.8
	yargs-18.0.0
	yargs-parser-22.0.0
	yocto-queue-0.1.0
	zwave-js-15.15.3
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"
RESTRICT="mirror"

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
