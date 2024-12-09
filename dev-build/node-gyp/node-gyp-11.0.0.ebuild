# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
inherit python-r1 yarn

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
YARN_PKGS=(
	node-gyp-11.0.0
	minipass-sized-1.0.3
	unique-filename-4.0.0
	shebang-regex-3.0.0
	ansi-regex-5.0.1
	ansi-styles-4.3.0
	make-fetch-happen-14.0.3
	yallist-4.0.0
	chownr-3.0.0
	minipass-7.1.2
	iconv-lite-0.6.3
	is-fullwidth-code-point-3.0.0
	jsbn-1.1.0
	path-key-3.1.1
	tar-7.4.3
	package-json-from-dist-1.0.1
	shebang-command-2.0.0
	semver-7.6.3
	sprintf-js-1.1.3
	color-name-1.1.4
	emoji-regex-9.2.2
	foreground-child-3.3.0
	minipass-collect-2.0.1
	isexe-3.1.1
	nopt-8.0.0
	string-width-4.2.3
	which-5.0.0
	env-paths-2.2.1
	socks-2.8.3
	emoji-regex-8.0.0
	@pkgjs/parseargs-0.11.0
	string-width-5.1.2
	minipass-3.3.6
	https-proxy-agent-7.0.6
	ansi-styles-6.2.1
	retry-0.12.0
	socks-proxy-agent-8.0.5
	safer-buffer-2.1.2
	http-proxy-agent-7.0.2
	@isaacs/fs-minipass-4.0.1
	ssri-12.0.0
	agent-base-7.1.3
	http-cache-semantics-4.1.1
	isexe-2.0.0
	path-scurry-1.11.1
	unique-slug-5.0.0
	signal-exit-4.1.0
	ansi-regex-6.1.0
	p-map-7.0.3
	@npmcli/agent-3.0.0
	lru-cache-10.4.3
	smart-buffer-4.2.0
	minizlib-3.0.1
	fs-minipass-3.0.3
	minipass-pipeline-1.2.4
	promise-retry-2.0.1
	err-code-2.0.3
	rimraf-5.0.10
	color-convert-2.0.1
	ms-2.1.3
	brace-expansion-2.0.1
	glob-10.4.5
	cacache-19.0.1
	minipass-flush-1.0.5
	mkdirp-3.0.1
	debug-4.4.0
	wrap-ansi-8.1.0
	jackspeak-3.4.3
	abbrev-2.0.0
	minimatch-9.0.5
	yallist-5.0.0
	eastasianwidth-0.2.0
	which-2.0.2
	exponential-backoff-3.1.1
	ip-address-9.0.5
	imurmurhash-0.1.4
	@npmcli/fs-4.0.0
	proc-log-5.0.0
	balanced-match-1.0.2
	encoding-0.1.13
	strip-ansi-6.0.1
	strip-ansi-7.1.0
	graceful-fs-4.2.11
	negotiator-1.0.0
	cross-spawn-7.0.6
	minipass-fetch-4.0.0
	@isaacs/cliui-8.0.2
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
