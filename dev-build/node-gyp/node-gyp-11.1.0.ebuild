# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
inherit python-r1 yarn

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
YARN_PKGS=(
	"${P}"
	abbrev-2.0.0
	agent-base-7.1.1
	agent-base-7.1.3
	ansi-regex-5.0.1
	ansi-regex-6.0.1
	ansi-styles-4.3.0
	ansi-styles-6.2.1
	balanced-match-1.0.2
	brace-expansion-2.0.1
	cacache-19.0.1
	chownr-3.0.0
	color-convert-2.0.1
	color-name-1.1.4
	cross-spawn-7.0.3
	debug-4.3.4
	eastasianwidth-0.2.0
	emoji-regex-8.0.0
	emoji-regex-9.2.2
	encoding-0.1.13
	env-paths-2.2.1
	err-code-2.0.3
	exponential-backoff-3.1.1
	foreground-child-3.1.1
	fs-minipass-3.0.3
	glob-10.3.12
	glob-10.4.5
	graceful-fs-4.2.11
	http-cache-semantics-4.1.1
	http-proxy-agent-7.0.2
	https-proxy-agent-7.0.4
	iconv-lite-0.6.3
	imurmurhash-0.1.4
	ip-address-9.0.5
	@isaacs/cliui-8.0.2
	@isaacs/fs-minipass-4.0.1
	isexe-2.0.0
	isexe-3.1.1
	is-fullwidth-code-point-3.0.0
	jackspeak-2.3.6
	jackspeak-3.4.3
	jsbn-1.1.0
	lru-cache-10.2.0
	lru-cache-6.0.0
	make-fetch-happen-14.0.3
	minimatch-9.0.4
	minimatch-9.0.5
	minipass-3.3.6
	minipass-7.0.4
	minipass-7.1.2
	minipass-collect-2.0.1
	minipass-fetch-4.0.0
	minipass-flush-1.0.5
	minipass-pipeline-1.2.4
	minipass-sized-1.0.3
	minizlib-3.0.1
	mkdirp-3.0.1
	ms-2.1.2
	negotiator-1.0.0
	nopt-8.0.0
	@npmcli/agent-3.0.0
	@npmcli/fs-4.0.0
	package-json-from-dist-1.0.1
	path-key-3.1.1
	path-scurry-1.10.2
	path-scurry-1.11.1
	@pkgjs/parseargs-0.11.0
	p-map-7.0.3
	proc-log-5.0.0
	promise-retry-2.0.1
	retry-0.12.0
	rimraf-5.0.10
	safer-buffer-2.1.2
	semver-7.6.0
	shebang-command-2.0.0
	shebang-regex-3.0.0
	signal-exit-4.1.0
	smart-buffer-4.2.0
	socks-2.8.3
	socks-proxy-agent-8.0.5
	sprintf-js-1.1.3
	ssri-12.0.0
	string-width-4.2.3
	string-width-5.1.2
	strip-ansi-6.0.1
	strip-ansi-7.1.0
	tar-7.4.3
	unique-filename-4.0.0
	unique-slug-5.0.0
	which-2.0.2
	which-5.0.0
	wrap-ansi-7.0.0
	wrap-ansi-8.1.0
	yallist-4.0.0
	yallist-5.0.0
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
