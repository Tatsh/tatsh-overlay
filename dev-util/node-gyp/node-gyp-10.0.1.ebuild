# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
inherit python-r1 yarn

DESCRIPTION="Node.js native addon build tool."
HOMEPAGE="https://www.npmjs.com/package/node-gyp"
YARN_PKGS=(
	"${P}"
	@isaacs/cliui-8.0.2
	@npmcli/agent-2.2.0
	@npmcli/fs-3.1.0
	@pkgjs/parseargs-0.11.0
	abbrev-2.0.0
	agent-base-7.1.0
	aggregate-error-3.1.0
	ansi-regex-5.0.1
	ansi-regex-6.0.1
	ansi-styles-4.3.0
	ansi-styles-6.2.1
	balanced-match-1.0.2
	brace-expansion-2.0.1
	cacache-18.0.0
	chownr-2.0.0
	clean-stack-2.2.0
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
	fs-minipass-2.1.0
	fs-minipass-3.0.2
	glob-10.3.0
	glob-10.3.10
	graceful-fs-4.2.10
	http-cache-semantics-4.1.1
	http-proxy-agent-7.0.0
	https-proxy-agent-7.0.2
	iconv-lite-0.6.3
	imurmurhash-0.1.4
	indent-string-4.0.0
	ip-2.0.0
	is-fullwidth-code-point-3.0.0
	is-lambda-1.0.1
	isexe-2.0.0
	isexe-3.1.1
	jackspeak-2.2.1
	jackspeak-2.3.6
	lru-cache-10.0.1
	lru-cache-7.8.1
	lru-cache-9.1.2
	make-fetch-happen-13.0.0
	minimatch-9.0.2
	minipass-3.1.6
	minipass-5.0.0
	minipass-6.0.2
	minipass-7.0.4
	minipass-collect-1.0.2
	minipass-fetch-3.0.3
	minipass-flush-1.0.5
	minipass-pipeline-1.2.4
	minipass-sized-1.0.3
	minizlib-2.1.2
	mkdirp-1.0.4
	ms-2.1.2
	negotiator-0.6.3
	nopt-7.2.0
	p-map-4.0.0
	path-key-3.1.1
	path-scurry-1.10.1
	path-scurry-1.9.2
	proc-log-3.0.0
	promise-retry-2.0.1
	retry-0.12.0
	safer-buffer-2.1.2
	semver-7.3.6
	shebang-command-2.0.0
	shebang-regex-3.0.0
	signal-exit-4.0.2
	smart-buffer-4.2.0
	socks-2.7.1
	socks-proxy-agent-8.0.2
	ssri-10.0.4
	string-width-4.2.3
	string-width-5.1.2
	strip-ansi-6.0.1
	strip-ansi-7.1.0
	tar-6.1.11
	unique-filename-3.0.0
	unique-slug-4.0.0
	which-2.0.2
	which-4.0.0
	wrap-ansi-7.0.0
	wrap-ansi-8.1.0
	yallist-4.0.0
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LICENSE="BSD-2 ISC MIT"
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
