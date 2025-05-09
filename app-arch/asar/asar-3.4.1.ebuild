# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="Create Electron app packages."
HOMEPAGE="https://github.com/electron/asar"
YARN_PKGS=(
	@electron/asar-3.4.1
	brace-expansion-1.1.11
	once-1.4.0
	commander-5.1.0
	wrappy-1.0.2
	balanced-match-1.0.2
	inflight-1.0.6
	path-is-absolute-1.0.1
	inherits-2.0.4
	minimatch-3.1.2
	concat-map-0.0.1
	fs.realpath-1.0.0
	glob-7.2.3
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

LICENSE="ISC MIT"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/@electron/asar/bin/${PN}.js"
	dosym "../$(get_libdir)/${PN}/node_modules/@electron/asar/bin/${PN}.js" "/usr/bin/${PN}"
}
