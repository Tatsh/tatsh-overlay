# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="Create Electron app packages."
HOMEPAGE="https://github.com/electron/asar"
YARN_PKGS=(
	@electron/asar-4.0.1
	@isaacs/cliui-8.0.2
	ansi-regex-5.0.1
	ansi-regex-6.1.0
	ansi-styles-4.3.0
	ansi-styles-6.2.1
	balanced-match-1.0.2
	brace-expansion-2.0.1
	color-convert-2.0.1
	color-name-1.1.4
	commander-13.1.0
	cross-spawn-7.0.6
	eastasianwidth-0.2.0
	emoji-regex-8.0.0
	emoji-regex-9.2.2
	foreground-child-3.3.1
	glob-11.0.2
	is-fullwidth-code-point-3.0.0
	isexe-2.0.0
	jackspeak-4.1.1
	lru-cache-11.1.0
	minimatch-10.0.1
	minipass-7.1.2
	package-json-from-dist-1.0.1
	path-key-3.1.1
	path-scurry-2.0.0
	shebang-command-2.0.0
	shebang-regex-3.0.0
	signal-exit-4.1.0
	string-width-4.2.3
	string-width-5.1.2
	strip-ansi-6.0.1
	strip-ansi-7.1.0
	which-2.0.2
	wrap-ansi-7.0.0
	wrap-ansi-8.1.0
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"
RESTRICT="mirror"

LICENSE="ISC MIT"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/@electron/asar/bin/${PN}.mjs"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/@electron/asar/bin/${PN}.mjs" "/usr/bin/${PN}"
}
