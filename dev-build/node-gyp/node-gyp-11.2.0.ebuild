# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit python-r1 yarn

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
YARN_PKGS=(
	node-gyp-11.2.0
	make-fetch-happen-14.0.3
	@pkgjs/parseargs-0.11.0
	ansi-regex-6.1.0
	cross-spawn-7.0.6
	path-key-3.1.1
	negotiator-1.0.0
	@npmcli/fs-4.0.0
	ansi-regex-5.0.1
	lru-cache-10.4.3
	color-name-1.1.4
	isexe-2.0.0
	chownr-3.0.0
	foreground-child-3.3.1
	iconv-lite-0.6.3
	fdir-6.4.4
	ansi-styles-4.3.0
	is-fullwidth-code-point-3.0.0
	shebang-regex-3.0.0
	emoji-regex-9.2.2
	tinyglobby-0.2.13
	minizlib-3.0.2
	socks-2.8.4
	wrap-ansi-8.1.0
	minipass-3.3.6
	path-scurry-1.11.1
	ms-2.1.3
	unique-filename-4.0.0
	minipass-fetch-4.0.1
	agent-base-7.1.3
	retry-0.12.0
	ip-address-9.0.5
	cacache-19.0.1
	p-map-7.0.3
	shebang-command-2.0.0
	signal-exit-4.1.0
	strip-ansi-6.0.1
	ansi-styles-6.2.1
	eastasianwidth-0.2.0
	which-2.0.2
	@isaacs/fs-minipass-4.0.1
	promise-retry-2.0.1
	package-json-from-dist-1.0.1
	exponential-backoff-3.1.2
	tar-7.4.3
	balanced-match-1.0.2
	jsbn-1.1.0
	safer-buffer-2.1.2
	@npmcli/agent-3.0.0
	encoding-0.1.13
	minimatch-9.0.5
	semver-7.7.1
	color-convert-2.0.1
	env-paths-2.2.1
	minipass-collect-2.0.1
	proc-log-5.0.0
	strip-ansi-7.1.0
	smart-buffer-4.2.0
	string-width-4.2.3
	yallist-4.0.0
	abbrev-3.0.1
	picomatch-4.0.2
	glob-10.4.5
	isexe-3.1.1
	nopt-8.1.0
	http-cache-semantics-4.1.1
	ssri-12.0.0
	yallist-5.0.0
	jackspeak-3.4.3
	@isaacs/cliui-8.0.2
	minipass-sized-1.0.3
	err-code-2.0.3
	https-proxy-agent-7.0.6
	sprintf-js-1.1.3
	which-5.0.0
	minipass-pipeline-1.2.4
	http-proxy-agent-7.0.2
	fs-minipass-3.0.3
	minipass-flush-1.0.5
	unique-slug-5.0.0
	brace-expansion-2.0.1
	minipass-7.1.2
	imurmurhash-0.1.4
	socks-proxy-agent-8.0.5
	mkdirp-3.0.1
	string-width-5.1.2
	debug-4.4.0
	graceful-fs-4.2.11
	emoji-regex-8.0.0
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LICENSE="Apache-2 BSD-2 ISC MIT"
KEYWORDS="~amd64"

BDEPEND="sys-apps/yarn"
RDEPEND="net-libs/nodejs:= ${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/${PN}/bin/${PN}.js"
	dosym "../$(get_libdir)/${PN}/node_modules/${PN}/bin/${PN}.js" "/usr/bin/${PN}"
}
