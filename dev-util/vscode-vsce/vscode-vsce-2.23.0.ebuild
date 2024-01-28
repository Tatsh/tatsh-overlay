# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="VS Code extensions manager for extension developers."
HOMEPAGE="https://code.visualstudio.com"
NPM_P="@${P/-/\/}"
NPM_PN="@${PN/-/\/}"
YARN_PKGS=(
	@vscode/vsce-2.23.0
	has-flag-3.0.0
	semver-7.5.4
	yazl-2.5.1
	has-proto-1.0.1
	mdurl-1.0.1
	safe-buffer-5.2.1
	ini-1.3.8
	dom-serializer-2.0.0
	keytar-7.9.0
	concat-map-0.0.1
	read-1.0.7
	simple-get-4.0.1
	color-name-1.1.3
	boolbase-1.0.0
	hosted-git-info-4.1.0
	brace-expansion-1.1.11
	gopd-1.0.1
	minimatch-3.1.2
	end-of-stream-1.4.4
	underscore-1.13.6
	node-addon-api-4.3.0
	xmlbuilder-11.0.1
	color-convert-1.9.3
	domelementtype-2.3.0
	fill-range-7.0.1
	lru-cache-6.0.0
	tar-fs-2.1.1
	micromatch-4.0.5
	rimraf-3.0.2
	mime-1.6.0
	escape-string-regexp-1.0.5
	supports-color-5.5.0
	tunnel-0.0.6
	semver-5.7.2
	braces-3.0.2
	buffer-5.7.1
	glob-7.2.3
	yauzl-2.10.0
	css-what-6.1.0
	xml2js-0.5.0
	call-bind-1.0.5
	pump-3.0.0
	define-data-property-1.1.1
	util-deprecate-1.0.2
	napi-build-utils-1.0.2
	uc.micro-1.0.6
	expand-template-2.0.3
	readable-stream-3.6.2
	inherits-2.0.4
	cheerio-1.0.0-rc.12
	parse5-7.1.2
	leven-3.1.0
	strip-json-comments-2.0.1
	hasown-2.0.0
	htmlparser2-8.0.2
	argparse-2.0.1
	balanced-match-1.0.2
	parse-semver-1.1.1
	buffer-crc32-0.2.13
	rc-1.2.8
	tar-stream-2.2.0
	path-is-absolute-1.0.1
	has-property-descriptors-1.0.1
	qs-6.11.2
	sax-1.3.0
	url-join-4.0.1
	tunnel-agent-0.6.0
	minimist-1.2.8
	ieee754-1.2.1
	is-number-7.0.0
	pend-1.2.0
	detect-libc-2.0.2
	typed-rest-client-1.8.11
	chalk-2.4.2
	object-inspect-1.13.1
	inflight-1.0.6
	github-from-package-0.0.0
	picomatch-2.3.1
	simple-concat-1.0.1
	fs-constants-1.0.0
	markdown-it-12.3.2
	mkdirp-classic-0.5.3
	commander-6.2.1
	string_decoder-1.3.0
	linkify-it-3.0.3
	entities-2.1.0
	css-select-5.1.0
	deep-extend-0.6.0
	entities-4.5.0
	azure-devops-node-api-11.2.0
	get-intrinsic-1.2.2
	bl-4.1.0
	prebuild-install-7.1.1
	fd-slicer-1.1.0
	mimic-response-3.1.0
	domutils-3.1.0
	decompress-response-6.0.0
	chownr-1.1.4
	mute-stream-0.0.8
	once-1.4.0
	nth-check-2.1.1
	function-bind-1.1.2
	parse5-htmlparser2-tree-adapter-7.0.0
	base64-js-1.5.1
	node-abi-3.54.0
	to-regex-range-5.0.1
	cheerio-select-2.1.0
	set-function-length-1.2.0
	domhandler-5.0.3
	jsonc-parser-3.2.1
	fs.realpath-1.0.0
	has-symbols-1.0.3
	ansi-styles-3.2.1
	yallist-4.0.0
	find-yarn-workspace-root-2.0.0
	side-channel-1.0.4
	wrappy-1.0.2
	tmp-0.2.1
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
