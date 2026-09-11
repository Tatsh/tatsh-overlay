# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="Shell for reading and writing PlayStation 2 HDD PFS filesystems."
HOMEPAGE="https://github.com/ps2homebrew/pfsshell"
SRC_URI="https://github.com/ps2homebrew/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

# The PS2SDK-derived subprojects are AFL-2.0; pfsshell itself is GPL-2.
LICENSE="AFL-2.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	# The PS2SDK-derived subprojects declare iomanx_* with types that do not
	# match their definitions, which LTO reports as -Wlto-type-mismatch.
	filter-lto

	meson_src_configure
}
