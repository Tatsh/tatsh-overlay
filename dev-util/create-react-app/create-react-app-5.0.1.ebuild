# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="Create React apps with no build configuration."
HOMEPAGE="https://www.npmjs.com/package/create-react-app"
YARN_PKGS=(
	"${P}"
	ansi-styles-4.3.0
	balanced-match-1.0.2
	block-stream-0.0.9
	brace-expansion-1.1.11
	buffer-from-0.1.2
	builtins-1.0.3
	chalk-4.1.2
	color-convert-2.0.1
	color-name-1.1.4
	commander-4.1.1
	concat-map-0.0.1
	core-util-is-1.0.3
	cross-spawn-7.0.3
	debug-2.6.9
	duplexer2-0.0.2
	envinfo-7.10.0
	fs-extra-10.1.0
	fs.realpath-1.0.0
	fstream-1.0.12
	fstream-ignore-1.0.5
	glob-7.2.3
	graceful-fs-4.2.11
	has-flag-4.0.0
	hyperquest-2.1.3
	inflight-1.0.6
	inherits-2.0.4
	isarray-0.0.1
	isarray-1.0.0
	isexe-2.0.0
	jsonfile-6.1.0
	kleur-3.0.3
	lru-cache-6.0.0
	minimatch-3.1.2
	minimist-1.2.8
	mkdirp-0.5.6
	ms-2.0.0
	once-1.4.0
	path-is-absolute-1.0.1
	path-key-3.1.1
	process-nextick-args-2.0.1
	prompts-2.4.2
	readable-stream-1.0.34
	readable-stream-1.1.14
	readable-stream-2.3.8
	rimraf-2.7.1
	rimraf-3.0.2
	safe-buffer-5.1.2
	semver-7.5.4
	shebang-command-2.0.0
	shebang-regex-3.0.0
	sisteransi-1.0.5
	string_decoder-0.10.31
	string_decoder-1.1.1
	supports-color-7.2.0
	tar-2.2.2
	tar-pack-3.4.1
	through2-0.6.5
	tmp-0.2.1
	uid-number-0.0.6
	universalify-2.0.0
	util-deprecate-1.0.2
	validate-npm-package-name-3.0.0
	which-2.0.2
	wrappy-1.0.2
	xtend-4.0.2
	yallist-4.0.0
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

LICENSE="BSD BSD-2 ISC MIT"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/${PN}/index.js"
	dosym "../$(get_libdir)/${PN}/node_modules/${PN}/index.js" "/usr/bin/${PN}"
}
