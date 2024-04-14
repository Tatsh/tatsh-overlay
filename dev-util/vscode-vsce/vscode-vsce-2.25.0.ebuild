# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="VS Code extensions manager for extension developers."
HOMEPAGE="https://code.visualstudio.com"
NPM_P="@${P/-/\/}"
NPM_PN="@${PN/-/\/}"
YARN_PKGS=(
	@vscode/vsce-2.25.0
	nth-check-2.1.1
	napi-build-utils-1.0.2
	read-1.0.7
	strip-json-comments-2.0.1
	has-symbols-1.0.3
	azure-devops-node-api-12.5.0
	buffer-crc32-0.2.13
	tmp-0.2.3
	call-bind-1.0.7
	escape-string-regexp-1.0.5
	markdown-it-12.3.2
	linkify-it-3.0.3
	path-is-absolute-1.0.1
	safe-buffer-5.2.1
	tunnel-agent-0.6.0
	domelementtype-2.3.0
	end-of-stream-1.4.4
	object-inspect-1.13.1
	xml2js-0.5.0
	supports-color-5.5.0
	parse-semver-1.1.1
	fd-slicer-1.1.0
	util-deprecate-1.0.2
	once-1.4.0
	delayed-stream-1.0.0
	css-select-5.1.0
	fs-constants-1.0.0
	gopd-1.0.1
	yallist-4.0.0
	mimic-response-3.1.0
	cheerio-1.0.0-rc.12
	brace-expansion-1.1.11
	mime-types-2.1.35
	url-join-4.0.1
	minimist-1.2.8
	form-data-4.0.0
	xmlbuilder-11.0.1
	parse5-htmlparser2-tree-adapter-7.0.0
	underscore-1.13.6
	asynckit-0.4.0
	mute-stream-0.0.8
	tunnel-0.0.6
	rc-1.2.8
	boolbase-1.0.0
	side-channel-1.0.6
	yazl-2.5.1
	color-convert-1.9.3
	detect-libc-2.0.3
	chownr-1.1.4
	lru-cache-6.0.0
	node-addon-api-4.3.0
	prebuild-install-7.1.2
	has-proto-1.0.3
	htmlparser2-8.0.2
	fs.realpath-1.0.0
	has-property-descriptors-1.0.2
	color-name-1.1.3
	buffer-5.7.1
	es-errors-1.3.0
	cheerio-select-2.1.0
	entities-4.5.0
	string_decoder-1.3.0
	inherits-2.0.4
	minimatch-3.1.2
	keytar-7.9.0
	yauzl-2.10.0
	leven-3.1.0
	hosted-git-info-4.1.0
	dom-serializer-2.0.0
	semver-5.7.2
	simple-concat-1.0.1
	set-function-length-1.2.2
	concat-map-0.0.1
	es-define-property-1.0.0
	ansi-styles-3.2.1
	jsonc-parser-3.2.1
	pump-3.0.0
	tar-stream-2.2.0
	entities-2.1.0
	cockatiel-3.1.2
	sax-1.3.0
	wrappy-1.0.2
	deep-extend-0.6.0
	expand-template-2.0.3
	commander-6.2.1
	typed-rest-client-1.8.11
	readable-stream-3.6.2
	balanced-match-1.0.2
	qs-6.12.1
	ieee754-1.2.1
	chalk-2.4.2
	domutils-3.1.0
	domhandler-5.0.3
	define-data-property-1.1.4
	base64-js-1.5.1
	semver-7.6.0
	argparse-2.0.1
	mkdirp-classic-0.5.3
	pend-1.2.0
	tar-fs-2.1.1
	function-bind-1.1.2
	parse5-7.1.2
	hasown-2.0.2
	uc.micro-1.0.6
	node-abi-3.57.0
	simple-get-4.0.1
	ini-1.3.8
	mime-db-1.52.0
	get-intrinsic-1.2.4
	combined-stream-1.0.8
	mime-1.6.0
	mdurl-1.0.1
	glob-7.2.3
	has-flag-3.0.0
	css-what-6.1.0
	bl-4.1.0
	inflight-1.0.6
	decompress-response-6.0.0
	github-from-package-0.0.0
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
