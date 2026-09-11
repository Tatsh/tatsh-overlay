# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# nodejs_remove_dev deletes yaml's dist/doc and browser/dist/doc, which are
# runtime modules rather than documentation, and the server then dies with
# MODULE_NOT_FOUND.
NODEJS_KEEP_DEV_FILES=1

inherit nodejs-mod

DESCRIPTION="Cross-platform automation framework for mobile, web and desktop apps."
HOMEPAGE="https://appium.io https://github.com/appium/appium"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"

# MIT is Appium's own; the rest come from the vendored dependencies. LGPL-3+ is
# the libvips copy inside sharp's prebuilt binary.
LICENSE="AFL-2.1 Apache-2.0 BSD BSD-2 BlueOak-1.0.0 CC-BY-3.0 CC0-1.0 ISC LGPL-3+ MIT PSF-2 Unlicense WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

# npm is not just a build tool here: `appium driver install` shells out to it at
# run time. The version floor is Appium's own engines.node, which it enforces
# on startup.
RDEPEND=">=net-libs/nodejs-20.19.0:=[npm]"

src_prepare() {
	nodejs-mod_src_prepare

	# Several dependencies ship prebuilt binaries for every platform they
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

	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/${PN}/index.js"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${PN}/index.js" "/usr/bin/${PN}"
}

pkg_postinst() {
	elog "Appium on its own automates nothing. Install a driver for whatever"
	elog "you want to automate, then start the server:"
	elog ""
	elog "    appium driver install uiautomator2   # Android"
	elog "    appium driver install xcuitest       # iOS"
	elog "    appium"
	elog ""
	elog "Drivers are downloaded per user into ~/.appium and can be listed with"
	elog "\"appium driver list\"."
}
