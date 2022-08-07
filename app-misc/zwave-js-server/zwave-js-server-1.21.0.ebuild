# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing systemd

DESCRIPTION="Small server wrapper around Z-Wave JS to access it via a WebSocket."
HOMEPAGE="https://github.com/zwave-js/zwave-js-server"
SRC_URI="https://registry.yarnpkg.com/@alcalzone/jsonl-db/-/jsonl-db-2.5.2.tgz -> node-@alcalzone-jsonl-db-2.5.2.tgz
	https://registry.yarnpkg.com/@alcalzone/pak/-/pak-0.8.1.tgz -> node-@alcalzone-pak-0.8.1.tgz
	https://registry.yarnpkg.com/@colors/colors/-/colors-1.5.0.tgz -> node-@colors-colors-1.5.0.tgz
	https://registry.yarnpkg.com/@dabh/diagnostics/-/diagnostics-2.0.3.tgz -> node-@dabh-diagnostics-2.0.3.tgz
	https://registry.yarnpkg.com/@homebridge/ciao/-/ciao-1.1.4.tgz -> node-@homebridge-ciao-1.1.4.tgz
	https://registry.yarnpkg.com/@sentry/core/-/core-6.19.7.tgz -> node-@sentry-core-6.19.7.tgz
	https://registry.yarnpkg.com/@sentry/hub/-/hub-6.19.7.tgz -> node-@sentry-hub-6.19.7.tgz
	https://registry.yarnpkg.com/@sentry/integrations/-/integrations-6.19.7.tgz -> node-@sentry-integrations-6.19.7.tgz
	https://registry.yarnpkg.com/@sentry/minimal/-/minimal-6.19.7.tgz -> node-@sentry-minimal-6.19.7.tgz
	https://registry.yarnpkg.com/@sentry/node/-/node-6.19.7.tgz -> node-@sentry-node-6.19.7.tgz
	https://registry.yarnpkg.com/@sentry/types/-/types-6.19.7.tgz -> node-@sentry-types-6.19.7.tgz
	https://registry.yarnpkg.com/@sentry/utils/-/utils-6.19.7.tgz -> node-@sentry-utils-6.19.7.tgz
	https://registry.yarnpkg.com/@serialport/binding-mock/-/binding-mock-10.2.2.tgz -> node-@serialport-binding-mock-10.2.2.tgz
	https://registry.yarnpkg.com/@serialport/bindings-cpp/-/bindings-cpp-10.7.0.tgz -> node-@serialport-bindings-cpp-10.7.0.tgz
	https://registry.yarnpkg.com/@serialport/bindings-interface/-/bindings-interface-1.2.1.tgz -> node-@serialport-bindings-interface-1.2.1.tgz
	https://registry.yarnpkg.com/@serialport/bindings-interface/-/bindings-interface-1.2.2.tgz -> node-@serialport-bindings-interface-1.2.2.tgz
	https://registry.yarnpkg.com/@serialport/parser-byte-length/-/parser-byte-length-10.3.0.tgz -> node-@serialport-parser-byte-length-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-cctalk/-/parser-cctalk-10.3.0.tgz -> node-@serialport-parser-cctalk-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-delimiter/-/parser-delimiter-10.3.0.tgz -> node-@serialport-parser-delimiter-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-inter-byte-timeout/-/parser-inter-byte-timeout-10.3.0.tgz -> node-@serialport-parser-inter-byte-timeout-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-packet-length/-/parser-packet-length-10.3.0.tgz -> node-@serialport-parser-packet-length-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-readline/-/parser-readline-10.3.0.tgz -> node-@serialport-parser-readline-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-ready/-/parser-ready-10.3.0.tgz -> node-@serialport-parser-ready-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-regex/-/parser-regex-10.3.0.tgz -> node-@serialport-parser-regex-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-slip-encoder/-/parser-slip-encoder-10.3.0.tgz -> node-@serialport-parser-slip-encoder-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/parser-spacepacket/-/parser-spacepacket-10.3.0.tgz -> node-@serialport-parser-spacepacket-10.3.0.tgz
	https://registry.yarnpkg.com/@serialport/stream/-/stream-10.3.0.tgz -> node-@serialport-stream-10.3.0.tgz
	https://registry.yarnpkg.com/@zwave-js/config/-/config-9.6.1.tgz -> node-@zwave-js-config-9.6.1.tgz
	https://registry.yarnpkg.com/@zwave-js/core/-/core-9.6.0.tgz -> node-@zwave-js-core-9.6.0.tgz
	https://registry.yarnpkg.com/@zwave-js/host/-/host-9.6.0.tgz -> node-@zwave-js-host-9.6.0.tgz
	https://registry.yarnpkg.com/file-stream-rotator/-/file-stream-rotator-0.6.1.tgz -> node-file-stream-rotator-0.6.1.tgz
	https://registry.yarnpkg.com/@zwave-js/nvmedit/-/nvmedit-9.6.0.tgz -> node-@zwave-js-nvmedit-9.6.0.tgz
	https://registry.yarnpkg.com/@zwave-js/serial/-/serial-9.6.0.tgz -> node-@zwave-js-serial-9.6.0.tgz
	https://registry.yarnpkg.com/@zwave-js/server/-/server-${PV}.tgz -> node-@${P}.tgz
	https://registry.yarnpkg.com/@zwave-js/shared/-/shared-9.6.0.tgz -> node-@zwave-js-shared-9.6.0.tgz
	https://registry.yarnpkg.com/winston-daily-rotate-file/-/winston-daily-rotate-file-4.7.1.tgz -> node-winston-daily-rotate-file-4.7.1.tgz
	https://registry.yarnpkg.com/agent-base/-/agent-base-6.0.2.tgz -> node-agent-base-6.0.2.tgz
	https://registry.yarnpkg.com/alcalzone-shared/-/alcalzone-shared-4.0.1.tgz -> node-alcalzone-shared-4.0.1.tgz
	https://registry.yarnpkg.com/ansi-colors/-/ansi-colors-4.1.3.tgz -> node-ansi-colors-4.1.3.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-5.0.1.tgz -> node-ansi-regex-5.0.1.tgz
	https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-4.3.0.tgz -> node-ansi-styles-4.3.0.tgz
	https://registry.yarnpkg.com/async/-/async-3.2.3.tgz -> node-async-3.2.3.tgz
	https://registry.yarnpkg.com/axios/-/axios-0.26.1.tgz -> node-axios-0.26.1.tgz
	https://registry.yarnpkg.com/axios/-/axios-0.27.2.tgz -> node-axios-0.27.2.tgz
	https://registry.yarnpkg.com/buffer-from/-/buffer-from-1.1.2.tgz -> node-buffer-from-1.1.2.tgz
	https://registry.yarnpkg.com/cliui/-/cliui-7.0.4.tgz -> node-cliui-7.0.4.tgz
	https://registry.yarnpkg.com/color-convert/-/color-convert-1.9.3.tgz -> node-color-convert-1.9.3.tgz
	https://registry.yarnpkg.com/color-convert/-/color-convert-2.0.1.tgz -> node-color-convert-2.0.1.tgz
	https://registry.yarnpkg.com/color-name/-/color-name-1.1.3.tgz -> node-color-name-1.1.3.tgz
	https://registry.yarnpkg.com/color-name/-/color-name-1.1.4.tgz -> node-color-name-1.1.4.tgz
	https://registry.yarnpkg.com/color-string/-/color-string-1.9.1.tgz -> node-color-string-1.9.1.tgz
	https://registry.yarnpkg.com/color/-/color-3.2.1.tgz -> node-color-3.2.1.tgz
	https://registry.yarnpkg.com/colorspace/-/colorspace-1.1.4.tgz -> node-colorspace-1.1.4.tgz
	https://registry.yarnpkg.com/cookie/-/cookie-0.4.2.tgz -> node-cookie-0.4.2.tgz
	https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-7.0.3.tgz -> node-cross-spawn-7.0.3.tgz
	https://registry.yarnpkg.com/dayjs/-/dayjs-1.11.4.tgz -> node-dayjs-1.11.4.tgz
	https://registry.yarnpkg.com/debug/-/debug-4.3.4.tgz -> node-debug-4.3.4.tgz
	https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-8.0.0.tgz -> node-emoji-regex-8.0.0.tgz
	https://registry.yarnpkg.com/enabled/-/enabled-2.0.0.tgz -> node-enabled-2.0.0.tgz
	https://registry.yarnpkg.com/escalade/-/escalade-3.1.1.tgz -> node-escalade-3.1.1.tgz
	https://registry.yarnpkg.com/execa/-/execa-5.1.1.tgz -> node-execa-5.1.1.tgz
	https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz -> node-fast-deep-equal-3.1.3.tgz
	https://registry.yarnpkg.com/fecha/-/fecha-4.2.3.tgz -> node-fecha-4.2.3.tgz
	https://registry.yarnpkg.com/fn.name/-/fn.name-1.1.0.tgz -> node-fn.name-1.1.0.tgz
	https://registry.yarnpkg.com/follow-redirects/-/follow-redirects-1.15.0.tgz -> node-follow-redirects-1.15.0.tgz
	https://registry.yarnpkg.com/fs-extra/-/fs-extra-10.1.0.tgz -> node-fs-extra-10.1.0.tgz
	https://registry.yarnpkg.com/get-caller-file/-/get-caller-file-2.0.5.tgz -> node-get-caller-file-2.0.5.tgz
	https://registry.yarnpkg.com/get-stream/-/get-stream-6.0.1.tgz -> node-get-stream-6.0.1.tgz
	https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.2.10.tgz -> node-graceful-fs-4.2.10.tgz
	https://registry.yarnpkg.com/https-proxy-agent/-/https-proxy-agent-5.0.1.tgz -> node-https-proxy-agent-5.0.1.tgz
	https://registry.yarnpkg.com/human-signals/-/human-signals-2.1.0.tgz -> node-human-signals-2.1.0.tgz
	https://registry.yarnpkg.com/immediate/-/immediate-3.0.6.tgz -> node-immediate-3.0.6.tgz
	https://registry.yarnpkg.com/inherits/-/inherits-2.0.4.tgz -> node-inherits-2.0.4.tgz
	https://registry.yarnpkg.com/is-arrayish/-/is-arrayish-0.3.2.tgz -> node-is-arrayish-0.3.2.tgz
	https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz -> node-is-fullwidth-code-point-3.0.0.tgz
	https://registry.yarnpkg.com/is-stream/-/is-stream-2.0.1.tgz -> node-is-stream-2.0.1.tgz
	https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz -> node-isexe-2.0.0.tgz
	https://registry.yarnpkg.com/json-logic-js/-/json-logic-js-2.0.2.tgz -> node-json-logic-js-2.0.2.tgz
	https://registry.yarnpkg.com/json5/-/json5-2.2.1.tgz -> node-json5-2.2.1.tgz
	https://registry.yarnpkg.com/jsonfile/-/jsonfile-6.1.0.tgz -> node-jsonfile-6.1.0.tgz
	https://registry.yarnpkg.com/kuler/-/kuler-2.0.0.tgz -> node-kuler-2.0.0.tgz
	https://registry.yarnpkg.com/lie/-/lie-3.1.1.tgz -> node-lie-3.1.1.tgz
	https://registry.yarnpkg.com/localforage/-/localforage-1.10.0.tgz -> node-localforage-1.10.0.tgz
	https://registry.yarnpkg.com/logform/-/logform-2.4.2.tgz -> node-logform-2.4.2.tgz
	https://registry.yarnpkg.com/logform/-/logform-2.4.0.tgz -> node-logform-2.4.0.tgz
	https://registry.yarnpkg.com/lru-cache/-/lru-cache-6.0.0.tgz -> node-lru-cache-6.0.0.tgz
	https://registry.yarnpkg.com/lru-cache/-/lru-cache-7.8.1.tgz -> node-lru-cache-7.8.1.tgz
	https://registry.yarnpkg.com/lru_map/-/lru_map-0.3.3.tgz -> node-lru_map-0.3.3.tgz
	https://registry.yarnpkg.com/merge-stream/-/merge-stream-2.0.0.tgz -> node-merge-stream-2.0.0.tgz
	https://registry.yarnpkg.com/mimic-fn/-/mimic-fn-2.1.0.tgz -> node-mimic-fn-2.1.0.tgz
	https://registry.yarnpkg.com/minimist/-/minimist-1.2.6.tgz -> node-minimist-1.2.6.tgz
	https://registry.yarnpkg.com/moment/-/moment-2.29.3.tgz -> node-moment-2.29.3.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz -> node-ms-2.1.2.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.3.tgz -> node-ms-2.1.3.tgz
	https://registry.yarnpkg.com/node-addon-api/-/node-addon-api-4.3.0.tgz -> node-node-addon-api-4.3.0.tgz
	https://registry.yarnpkg.com/node-gyp-build/-/node-gyp-build-4.4.0.tgz -> node-node-gyp-build-4.4.0.tgz
	https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-4.0.1.tgz -> node-npm-run-path-4.0.1.tgz
	https://registry.yarnpkg.com/nrf-intel-hex/-/nrf-intel-hex-1.3.0.tgz -> node-nrf-intel-hex-1.3.0.tgz
	https://registry.yarnpkg.com/object-hash/-/object-hash-2.2.0.tgz -> node-object-hash-2.2.0.tgz
	https://registry.yarnpkg.com/one-time/-/one-time-1.0.0.tgz -> node-one-time-1.0.0.tgz
	https://registry.yarnpkg.com/onetime/-/onetime-5.1.2.tgz -> node-onetime-5.1.2.tgz
	https://registry.yarnpkg.com/path-key/-/path-key-3.1.1.tgz -> node-path-key-3.1.1.tgz
	https://registry.yarnpkg.com/proper-lockfile/-/proper-lockfile-4.1.2.tgz -> node-proper-lockfile-4.1.2.tgz
	https://registry.yarnpkg.com/readable-stream/-/readable-stream-3.6.0.tgz -> node-readable-stream-3.6.0.tgz
	https://registry.yarnpkg.com/reflect-metadata/-/reflect-metadata-0.1.13.tgz -> node-reflect-metadata-0.1.13.tgz
	https://registry.yarnpkg.com/require-directory/-/require-directory-2.1.1.tgz -> node-require-directory-2.1.1.tgz
	https://registry.yarnpkg.com/retry/-/retry-0.12.0.tgz -> node-retry-0.12.0.tgz
	https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.2.1.tgz -> node-safe-buffer-5.2.1.tgz
	https://registry.yarnpkg.com/safe-stable-stringify/-/safe-stable-stringify-2.3.1.tgz -> node-safe-stable-stringify-2.3.1.tgz
	https://registry.yarnpkg.com/semver/-/semver-7.3.7.tgz -> node-semver-7.3.7.tgz
	https://registry.yarnpkg.com/serialport/-/serialport-10.4.0.tgz -> node-serialport-10.4.0.tgz
	https://registry.yarnpkg.com/shebang-command/-/shebang-command-2.0.0.tgz -> node-shebang-command-2.0.0.tgz
	https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-3.0.0.tgz -> node-shebang-regex-3.0.0.tgz
	https://registry.yarnpkg.com/signal-exit/-/signal-exit-3.0.7.tgz -> node-signal-exit-3.0.7.tgz
	https://registry.yarnpkg.com/simple-swizzle/-/simple-swizzle-0.2.2.tgz -> node-simple-swizzle-0.2.2.tgz
	https://registry.yarnpkg.com/source-map-support/-/source-map-support-0.5.21.tgz -> node-source-map-support-0.5.21.tgz
	https://registry.yarnpkg.com/source-map/-/source-map-0.6.1.tgz -> node-source-map-0.6.1.tgz
	https://registry.yarnpkg.com/stack-trace/-/stack-trace-0.0.10.tgz -> node-stack-trace-0.0.10.tgz
	https://registry.yarnpkg.com/string-width/-/string-width-4.2.3.tgz -> node-string-width-4.2.3.tgz
	https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.3.0.tgz -> node-string_decoder-1.3.0.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-6.0.1.tgz -> node-strip-ansi-6.0.1.tgz
	https://registry.yarnpkg.com/strip-final-newline/-/strip-final-newline-2.0.0.tgz -> node-strip-final-newline-2.0.0.tgz
	https://registry.yarnpkg.com/text-hex/-/text-hex-1.0.0.tgz -> node-text-hex-1.0.0.tgz
	https://registry.yarnpkg.com/triple-beam/-/triple-beam-1.3.0.tgz -> node-triple-beam-1.3.0.tgz
	https://registry.yarnpkg.com/tslib/-/tslib-1.14.1.tgz -> node-tslib-1.14.1.tgz
	https://registry.yarnpkg.com/tslib/-/tslib-2.4.0.tgz -> node-tslib-2.4.0.tgz
	https://registry.yarnpkg.com/universalify/-/universalify-2.0.0.tgz -> node-universalify-2.0.0.tgz
	https://registry.yarnpkg.com/util-deprecate/-/util-deprecate-1.0.2.tgz -> node-util-deprecate-1.0.2.tgz
	https://registry.yarnpkg.com/which/-/which-2.0.2.tgz -> node-which-2.0.2.tgz
	https://registry.yarnpkg.com/winston-transport/-/winston-transport-4.5.0.tgz -> node-winston-transport-4.5.0.tgz
	https://registry.yarnpkg.com/winston/-/winston-3.7.2.tgz -> node-winston-3.7.2.tgz
	https://registry.yarnpkg.com/wrap-ansi/-/wrap-ansi-7.0.0.tgz -> node-wrap-ansi-7.0.0.tgz
	https://registry.yarnpkg.com/ws/-/ws-8.6.0.tgz -> node-ws-8.6.0.tgz
	https://registry.yarnpkg.com/xstate/-/xstate-4.32.0.tgz -> node-xstate-4.32.0.tgz
	https://registry.yarnpkg.com/y18n/-/y18n-5.0.8.tgz -> node-y18n-5.0.8.tgz
	https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-21.0.1.tgz -> node-yargs-parser-21.0.1.tgz
	https://registry.yarnpkg.com/yargs/-/yargs-17.5.1.tgz -> node-yargs-17.5.1.tgz
	https://registry.yarnpkg.com/zwave-js/-/zwave-js-9.6.2.tgz -> node-zwave-js-9.6.2.tgz
	https://registry.yarnpkg.com/form-data/-/form-data-4.0.0.tgz -> node-form-data-4.0.0.tgz
	https://registry.yarnpkg.com/asynckit/-/asynckit-0.4.0.tgz -> node-asynckit-0.4.0.tgz
	https://registry.yarnpkg.com/combined-stream/-/combined-stream-1.0.8.tgz -> node-combined-stream-1.0.8.tgz
	https://registry.yarnpkg.com/mime-types/-/mime-types-2.1.35.tgz -> node-mime-types-2.1.35.tgz
	https://registry.yarnpkg.com/yallist/-/yallist-4.0.0.tgz -> node-yallist-4.0.0.tgz
	https://registry.yarnpkg.com/delayed-stream/-/delayed-stream-1.0.0.tgz -> node-delayed-stream-1.0.0.tgz
	https://registry.yarnpkg.com/mime-db/-/mime-db-1.52.0.tgz -> node-mime-db-1.52.0.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

DOCS=( "${FILESDIR}/${PN}.keys.js.example" )

BDEPEND="sys-apps/yarn
	dev-util/node-gyp"
RDEPEND="net-libs/nodejs:="

S="${WORKDIR}"

src_unpack() {
	local archive
	for archive in ${A}; do
			case "${archive}" in
					*.tgz)
							;;
					*)
							unpack ${archive}
							;;
			esac
	done
}

src_prepare() {
	mkdir lib packages || die
	local file bn
	for file in "${DISTDIR}"/node-*.tgz; do
		bn=$(basename "$file")
		ln -s "${file}" "packages/${bn:5}" || die
	done
	default
}

src_configure() {
	yarn config set prefix "${HOME}/.node" || die
	yarn config set yarn-offline-mirror "$(realpath "${WORKDIR}/packages")" || die
}

src_compile() {
	cd lib || die
	cp "${FILESDIR}/${PN}-package.json" package.json || die
	cp "${FILESDIR}/${PN}-yarn.lock" yarn.lock || die
	env \
		npm_config_jobs=$(makeopts_jobs) \
		npm_config_verbose=true \
		npm_config_release=true \
		"npm_config_nodedir=${EPREFIX}/usr/include/node" \
		yarn install --production --offline --verbose --no-progress \
		--non-interactive --build-from-source || die
	rm -fR node_modules/@serialport/bindings-cpp/prebuilds/{darwin,android,win32,linux-arm}* \
		node_modules/@serialport/bindings-cpp/prebuilds/linux-x64/*musl.node \
		package.json || die
	find . -type d -empty -delete || die
	find . -type f '(' -name '*.ts*' -o -name '*.map' -o -iname '*.md' ')' -delete || die
	find . -type f -iname 'license*' -exec bzip2 {} \; || die
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}/node_modules
	doins -r lib/node_modules/*
	fperms 0755 /usr/$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist/bin/{client,server}.js
	dosym ../$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist/bin/client.js /usr/bin/zwave-client
	dosym ../$(get_libdir)/${PN}/node_modules/@zwave-js/server/dist/bin/server.js /usr/bin/zwave-server
	insinto /etc
	doins "${FILESDIR}/${PN}.config.js"
	systemd_newunit "${FILESDIR}/${PN}.service" "${PN}@.service"
	einstalldocs
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
