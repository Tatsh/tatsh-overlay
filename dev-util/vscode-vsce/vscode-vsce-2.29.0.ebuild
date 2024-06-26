# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="VS Code extensions manager for extension developers."
HOMEPAGE="https://code.visualstudio.com"
NPM_P="@${P/-/\/}"
NPM_PN="@${PN/-/\/}"
YARN_PKGS=(
	@vscode/vsce-2.29.0
	@azure/msal-common-14.12.0
	expand-template-2.0.3
	tunnel-agent-0.6.0
	tslib-2.6.3
	hasown-2.0.2
	end-of-stream-1.4.4
	underscore-1.13.6
	css-what-6.1.0
	simple-concat-1.0.1
	decompress-response-6.0.0
	@azure/core-tracing-1.1.2
	fs-constants-1.0.0
	object-inspect-1.13.2
	ini-1.3.8
	domelementtype-2.3.0
	escape-string-regexp-1.0.5
	mimic-response-3.1.0
	@vscode/vsce-sign-alpine-x64-2.0.2
	ms-2.1.2
	hosted-git-info-4.1.0
	htmlparser2-8.0.2
	get-intrinsic-1.2.4
	prebuild-install-7.1.2
	github-from-package-0.0.0
	domutils-3.1.0
	define-lazy-prop-2.0.0
	@vscode/vsce-sign-alpine-arm64-2.0.2
	tar-stream-2.2.0
	domhandler-5.0.3
	tar-fs-2.1.1
	jsonc-parser-3.2.1
	yauzl-2.10.0
	color-convert-1.9.3
	ms-2.1.3
	supports-color-5.5.0
	chownr-1.1.4
	ecdsa-sig-formatter-1.0.11
	jwa-2.0.0
	inflight-1.0.6
	mute-stream-0.0.8
	nth-check-2.1.1
	semver-5.7.2
	color-name-1.1.3
	@azure/abort-controller-1.1.0
	strip-json-comments-2.0.1
	node-abi-3.65.0
	rc-1.2.8
	jwa-1.4.1
	concat-map-0.0.1
	has-property-descriptors-1.0.2
	is-wsl-2.2.0
	buffer-equal-constant-time-1.0.1
	https-proxy-agent-7.0.4
	jsonwebtoken-9.0.2
	readable-stream-3.6.2
	safe-buffer-5.2.1
	lodash.isboolean-3.0.3
	mime-db-1.52.0
	mdurl-1.0.1
	bl-4.1.0
	css-select-5.1.0
	qs-6.12.1
	ieee754-1.2.1
	ansi-styles-3.2.1
	jws-3.2.2
	define-data-property-1.1.4
	node-addon-api-4.3.0
	@azure/identity-4.3.0
	@azure/msal-browser-3.17.0
	@vscode/vsce-sign-darwin-arm64-2.0.2
	@vscode/vsce-sign-darwin-x64-2.0.2
	@azure/core-auth-1.7.2
	path-is-absolute-1.0.1
	pend-1.2.0
	@azure/core-util-1.9.0
	jws-4.0.0
	form-data-4.0.0
	yazl-2.5.1
	has-symbols-1.0.3
	open-8.4.2
	string_decoder-1.3.0
	function-bind-1.1.2
	es-errors-1.3.0
	detect-libc-2.0.3
	http-proxy-agent-7.0.2
	simple-get-4.0.1
	brace-expansion-1.1.11
	@vscode/vsce-sign-linux-arm-2.0.2
	balanced-match-1.0.2
	tmp-0.2.3
	@vscode/vsce-sign-win32-arm64-2.0.2
	parse5-htmlparser2-tree-adapter-7.0.0
	yallist-4.0.0
	agent-base-7.1.1
	fs.realpath-1.0.0
	once-1.4.0
	minimatch-3.1.2
	commander-6.2.1
	tunnel-0.0.6
	base64-js-1.5.1
	entities-4.5.0
	linkify-it-3.0.3
	typed-rest-client-1.8.11
	mime-types-2.1.35
	inherits-2.0.4
	lru-cache-6.0.0
	util-deprecate-1.0.2
	argparse-2.0.1
	fd-slicer-1.1.0
	markdown-it-12.3.2
	lodash.once-4.1.1
	entities-2.1.0
	lodash.isinteger-4.0.4
	@azure/core-rest-pipeline-1.16.0
	chalk-2.4.2
	@azure/msal-node-2.9.2
	buffer-crc32-0.2.13
	gopd-1.0.1
	@vscode/vsce-sign-linux-arm64-2.0.2
	cockatiel-3.1.3
	leven-3.1.0
	has-flag-3.0.0
	@vscode/vsce-sign-2.0.4
	sax-1.4.1
	url-join-4.0.1
	uc.micro-1.0.6
	boolbase-1.0.0
	asynckit-0.4.0
	xml2js-0.5.0
	lodash.isnumber-3.0.3
	mkdirp-classic-0.5.3
	lodash.isplainobject-4.0.6
	semver-7.6.2
	uuid-8.3.2
	buffer-5.7.1
	glob-7.2.3
	debug-4.3.5
	azure-devops-node-api-12.5.0
	@vscode/vsce-sign-linux-x64-2.0.2
	lodash.isstring-4.0.1
	events-3.3.0
	cheerio-1.0.0-rc.12
	side-channel-1.0.6
	parse-semver-1.1.1
	read-1.0.7
	is-docker-2.2.1
	parse5-7.1.2
	delayed-stream-1.0.0
	pump-3.0.0
	keytar-7.9.0
	stoppable-1.1.0
	mime-1.6.0
	call-bind-1.0.7
	deep-extend-0.6.0
	@azure/logger-1.1.2
	@vscode/vsce-sign-win32-x64-2.0.2
	dom-serializer-2.0.0
	es-define-property-1.0.0
	lodash.includes-4.3.0
	napi-build-utils-1.0.2
	cheerio-select-2.1.0
	@azure/abort-controller-2.1.2
	wrappy-1.0.2
	xmlbuilder-11.0.1
	minimist-1.2.8
	has-proto-1.0.3
	@azure/core-client-1.9.2
	combined-stream-1.0.8
	set-function-length-1.2.2
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

BDEPEND="dev-libs/glib"
LICENSE="BSD-2 MIT Apache-2 ISC MIT PSF-2"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/${NPM_PN}/vsce"
	dosym "../$(get_libdir)/${PN}/node_modules/${NPM_PN}/vsce" "/usr/bin/vsce"
}
