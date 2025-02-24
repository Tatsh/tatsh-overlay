# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
inherit python-r1 yarn

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
YARN_PKGS=(
	node-gyp-11.1.0
	tar-7.4.3
	@isaacs/cliui-8.0.2
	minipass-pipeline-1.2.4
	jackspeak-3.4.3
	cacache-19.0.1
	fs-minipass-3.0.3
	rimraf-5.0.10
	yallist-5.0.0
	make-fetch-happen-14.0.3
	package-json-from-dist-1.0.1
	smart-buffer-4.2.0
	minipass-sized-1.0.3
	err-code-2.0.3
	which-2.0.2
	path-key-3.1.1
	@npmcli/agent-3.0.0
	@pkgjs/parseargs-0.11.0
	emoji-regex-8.0.0
	jsbn-1.1.0
	lru-cache-10.4.3
	path-scurry-1.11.1
	socks-proxy-agent-8.0.5
	ansi-regex-5.0.1
	emoji-regex-9.2.2
	minipass-collect-2.0.1
	imurmurhash-0.1.4
	string-width-5.1.2
	ansi-styles-4.3.0
	balanced-match-1.0.2
	minimatch-9.0.5
	agent-base-7.1.3
	shebang-command-2.0.0
	p-map-7.0.3
	minipass-flush-1.0.5
	string-width-4.2.3
	unique-filename-4.0.0
	negotiator-1.0.0
	is-fullwidth-code-point-3.0.0
	env-paths-2.2.1
	ansi-styles-6.2.1
	graceful-fs-4.2.11
	http-proxy-agent-7.0.2
	color-convert-2.0.1
	retry-0.12.0
	glob-10.4.5
	color-name-1.1.4
	eastasianwidth-0.2.0
	encoding-0.1.13
	iconv-lite-0.6.3
	strip-ansi-7.1.0
	ms-2.1.3
	wrap-ansi-8.1.0
	chownr-3.0.0
	isexe-3.1.1
	isexe-2.0.0
	which-5.0.0
	minizlib-3.0.1
	proc-log-5.0.0
	exponential-backoff-3.1.2
	minipass-7.1.2
	brace-expansion-2.0.1
	shebang-regex-3.0.0
	@isaacs/fs-minipass-4.0.1
	sprintf-js-1.1.3
	minipass-3.3.6
	abbrev-3.0.0
	yallist-4.0.0
	ssri-12.0.0
	nopt-8.1.0
	signal-exit-4.1.0
	cross-spawn-7.0.6
	http-cache-semantics-4.1.1
	ip-address-9.0.5
	minipass-fetch-4.0.0
	mkdirp-3.0.1
	@npmcli/fs-4.0.0
	https-proxy-agent-7.0.6
	debug-4.4.0
	safer-buffer-2.1.2
	promise-retry-2.0.1
	unique-slug-5.0.0
	semver-7.7.1
	ansi-regex-6.1.0
	strip-ansi-6.0.1
	socks-2.8.4
	foreground-child-3.3.0
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
