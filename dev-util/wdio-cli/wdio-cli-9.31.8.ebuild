# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# nodejs_remove_dev deletes anything called scripts, and webdriverio keeps
# build/scripts/polyfill.js, which node.js imports on startup. Without it the
# runner dies with ERR_MODULE_NOT_FOUND before doing anything.
NODEJS_KEEP_DEV_FILES=1

inherit nodejs-mod

DESCRIPTION="WebdriverIO testrunner command line interface."
HOMEPAGE="https://webdriver.io https://github.com/webdriverio/webdriverio"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"

# MIT is WebdriverIO's own; the rest come from the vendored dependencies.
LICENSE="0BSD Apache-2.0 BSD BSD-2 BlueOak-1.0.0 CC-BY-3.0 CC-BY-4.0 CC0-1.0 ISC MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

# The floor is @wdio/cli's own engines.node.
RDEPEND=">=net-libs/nodejs-18.20.0:="

src_prepare() {
	nodejs-mod_src_prepare

	# The bare-* modules ship prebuilt binaries for every platform they
	# support. The ones for other platforms are dead weight here, and QA
	# rightly reports unresolved sonames for them.
	local dir
	for dir in node_modules/*/prebuilds/*/; do
		[[ -d ${dir} && ${dir} != */prebuilds/linux-x64/ ]] || continue
		rm -r "${dir}" || die
	done
}

src_install() {
	nodejs-mod_src_install

	local bin="/usr/$(get_libdir)/node_modules/${PN}/node_modules/@wdio/cli/bin/wdio.js"
	fperms 0755 "${bin}"
	dosym "..${bin#/usr}" /usr/bin/wdio
}

pkg_postinst() {
	elog "This installs the wdio test runner only. A project still needs its"
	elog "own wdio.conf.js and whichever service and reporter packages it"
	elog "uses; those are resolved from the project, not from here."
}
