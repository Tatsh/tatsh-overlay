# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
inherit python-r1 yarn

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
YARN_PKGS=(
	node-gyp-10.2.0
	jsbn-1.1.0
	ssri-10.0.6
	emoji-regex-9.2.2
	isexe-3.1.1
	lru-cache-10.4.3
	minipass-5.0.0
	string-width-4.2.3
	is-lambda-1.0.1
	eastasianwidth-0.2.0
	@npmcli/fs-3.1.1
	@pkgjs/parseargs-0.11.0
	minipass-7.1.2
	imurmurhash-0.1.4
	minipass-collect-2.0.1
	http-proxy-agent-7.0.2
	proc-log-4.2.0
	cacache-18.0.4
	promise-retry-2.0.1
	string-width-5.1.2
	chownr-2.0.0
	cross-spawn-7.0.3
	wrap-ansi-8.1.0
	smart-buffer-4.2.0
	http-cache-semantics-4.1.1
	package-json-from-dist-1.0.0
	minipass-3.3.6
	semver-7.6.2
	clean-stack-2.2.0
	shebang-command-2.0.0
	p-map-4.0.0
	@npmcli/agent-2.2.2
	path-scurry-1.11.1
	aggregate-error-3.1.0
	debug-4.3.5
	strip-ansi-7.1.0
	shebang-regex-3.0.0
	fs-minipass-2.1.0
	foreground-child-3.2.1
	is-fullwidth-code-point-3.0.0
	ansi-styles-6.2.1
	exponential-backoff-3.1.1
	ansi-regex-6.0.1
	ms-2.1.2
	yallist-4.0.0
	ansi-regex-5.0.1
	balanced-match-1.0.2
	indent-string-4.0.0
	retry-0.12.0
	brace-expansion-2.0.1
	color-name-1.1.4
	minizlib-2.1.2
	env-paths-2.2.1
	color-convert-2.0.1
	path-key-3.1.1
	abbrev-2.0.0
	sprintf-js-1.1.3
	unique-filename-3.0.0
	which-4.0.0
	which-2.0.2
	minipass-fetch-3.0.5
	err-code-2.0.3
	tar-6.2.1
	jackspeak-3.4.3
	mkdirp-1.0.4
	agent-base-7.1.1
	ip-address-9.0.5
	graceful-fs-4.2.11
	minipass-sized-1.0.3
	minipass-flush-1.0.5
	@isaacs/cliui-8.0.2
	encoding-0.1.13
	minipass-pipeline-1.2.4
	safer-buffer-2.1.2
	isexe-2.0.0
	signal-exit-4.1.0
	strip-ansi-6.0.1
	unique-slug-4.0.0
	minimatch-9.0.5
	socks-proxy-agent-8.0.4
	https-proxy-agent-7.0.5
	glob-10.4.5
	iconv-lite-0.6.3
	nopt-7.2.1
	socks-2.8.3
	ansi-styles-4.3.0
	emoji-regex-8.0.0
	fs-minipass-3.0.3
	negotiator-0.6.3
	make-fetch-happen-13.0.1
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
