# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="VS Code Extensions Manager"
HOMEPAGE="https://code.visualstudio.com"
NPM_P="@${P/-/\/}"
NPM_PN="@${PN/-/\/}"
YARN_PKGS=(
	${NPM_P}
	ansi-styles-3.2.1
	argparse-2.0.1
	azure-devops-node-api-11.2.0
	balanced-match-1.0.2
	base64-js-1.5.1
	bl-4.1.0
	boolbase-1.0.0
	brace-expansion-1.1.11
	buffer-5.7.1
	buffer-crc32-0.2.13
	call-bind-1.0.2
	chalk-2.4.2
	cheerio-1.0.0-rc.12
	cheerio-select-2.1.0
	chownr-1.1.4
	color-convert-1.9.3
	color-name-1.1.3
	commander-6.2.1
	concat-map-0.0.1
	css-select-5.1.0
	css-what-6.1.0
	decompress-response-6.0.0
	deep-extend-0.6.0
	detect-libc-2.0.2
	dom-serializer-2.0.0
	domelementtype-2.3.0
	domhandler-5.0.3
	domutils-3.1.0
	end-of-stream-1.4.4
	entities-2.1.0
	entities-4.5.0
	escape-string-regexp-1.0.5
	expand-template-2.0.3
	fd-slicer-1.1.0
	fs-constants-1.0.0
	fs.realpath-1.0.0
	function-bind-1.1.1
	get-intrinsic-1.2.1
	github-from-package-0.0.0
	glob-7.2.3
	has-1.0.3
	has-flag-3.0.0
	has-proto-1.0.1
	has-symbols-1.0.3
	hosted-git-info-4.1.0
	htmlparser2-8.0.2
	ieee754-1.2.1
	inflight-1.0.6
	inherits-2.0.4
	ini-1.3.8
	jsonc-parser-3.2.0
	keytar-7.9.0
	leven-3.1.0
	linkify-it-3.0.3
	lru-cache-6.0.0
	markdown-it-12.3.2
	mdurl-1.0.1
	mime-1.6.0
	mimic-response-3.1.0
	minimatch-3.1.2
	minimist-1.2.8
	mkdirp-classic-0.5.3
	mute-stream-0.0.8
	napi-build-utils-1.0.2
	node-abi-3.47.0
	node-addon-api-4.3.0
	nth-check-2.1.1
	object-inspect-1.12.3
	once-1.4.0
	parse-semver-1.1.1
	parse5-7.1.2
	parse5-htmlparser2-tree-adapter-7.0.0
	path-is-absolute-1.0.1
	pend-1.2.0
	prebuild-install-7.1.1
	pump-3.0.0
	qs-6.11.2
	rc-1.2.8
	read-1.0.7
	readable-stream-3.6.2
	rimraf-3.0.2
	safe-buffer-5.2.1
	sax-1.2.4
	semver-5.7.2
	semver-7.5.4
	side-channel-1.0.4
	simple-concat-1.0.1
	simple-get-4.0.1
	string_decoder-1.3.0
	strip-json-comments-2.0.1
	supports-color-5.5.0
	tar-fs-2.1.1
	tar-stream-2.2.0
	tmp-0.2.1
	tunnel-0.0.6
	tunnel-agent-0.6.0
	typed-rest-client-1.8.11
	uc.micro-1.0.6
	underscore-1.13.6
	url-join-4.0.1
	util-deprecate-1.0.2
	wrappy-1.0.2
	xml2js-0.5.0
	xmlbuilder-11.0.1
	yallist-4.0.0
	yauzl-2.10.0
	yazl-2.5.1
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

LICENSE="BSD-2 MIT Apache-2 ISC MIT PSF-2"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/${NPM_PN}/vsce"
	dosym "../$(get_libdir)/${PN}/node_modules/${NPM_PN}/vsce" "/usr/bin/vsce"
}
