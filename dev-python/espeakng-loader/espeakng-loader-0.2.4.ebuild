# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

COMMIT="146599e29be31bf17d99f0bcb7dbb2f92aef3d95"

DESCRIPTION="Shared library loader for eSpeak NG."
HOMEPAGE="https://github.com/thewh1teagle/espeakng-loader"
SRC_URI="https://github.com/thewh1teagle/espeakng-loader/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-accessibility/espeak-ng"

PATCHES=( "${FILESDIR}/${PN}-fix-paths.patch" )

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	distutils-r1_src_prepare
	sed -re "s/@EPREFIX@/${EPREFIX}/g" -e "s/@LIB_DIR@/$(get_libdir)/g" \
		-i src/espeakng_loader/__init__.py || die
}
