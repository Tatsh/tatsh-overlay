# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Low-level cryptographic primitives from Apple."
HOMEPAGE="https://developer.apple.com/security/"
SRC_URI="${P}.zip"
#RESTRICT="fetch"

LICENSE="corecrypto"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

pkg_nofetch() {
	elog "Download '${PN}.zip' from https://developer.apple.com/security/ or use the following command:"
	elog
	elog "  curl 'https://developer.apple.com/file/?file=security&agree=Yes' -H 'Referer: https://developer.apple.com/security/' -o /var/cache/distfiles/corecrypto.zip"
	elog
	elog "Place it into your DISTDIR directory renamed to 'corecrypto-2024.zip'."
}

src_prepare() {
	sed -re '1s/(.*)/# \1/' -e '/.*scripts\/code-coverage.cmake.*/d' -i CMakeLists.txt || die
	sed -re '/ccsha2\/src\/ccsha256_trng_di\.c/d' -e 's|corecrypto_static/||' -i CoreCryptoSources.cmake || die
	cmake_src_prepare
}
