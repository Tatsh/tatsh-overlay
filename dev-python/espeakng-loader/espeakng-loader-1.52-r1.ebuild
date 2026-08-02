# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1

COMMIT="0ddc87adf77e5850d7eeb542ac8a87d421b64daa"

DESCRIPTION="Shared library loader for eSpeak NG."
HOMEPAGE="https://github.com/thewh1teagle/espeakng-loader"
SRC_URI="https://github.com/thewh1teagle/espeakng-loader/archive/${COMMIT}.tar.gz
	-> ${P}-${COMMIT:0:8}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-accessibility/espeak-ng"

PATCHES=( "${FILESDIR}/${PN}-fix-paths.patch" )

src_prepare() {
	distutils-r1_src_prepare
	sed -re "s/@EPREFIX@/${EPREFIX}/g" -e "s/@LIB_DIR@/$(get_libdir)/g" \
		-i src/espeakng_loader/__init__.py || die
}
