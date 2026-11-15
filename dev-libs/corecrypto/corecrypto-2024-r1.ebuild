# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Low-level cryptographic primitives from Apple"
HOMEPAGE="https://developer.apple.com/security/"
SRC_URI="${P}.zip"
LICENSE="corecrypto"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"

BDEPEND="app-arch/unzip"

pkg_nofetch() {
	elog "Download '${PN}.zip' from https://developer.apple.com/security/ or use the following command (change output directory if necessary):"
	elog
	elog "  curl 'https://developer.apple.com/file/?file=security&agree=Yes' -H 'Referer: https://developer.apple.com/security/' -o /var/cache/distfiles/${P}.zip"
	elog
	elog "Place it into your DISTDIR directory renamed to 'corecrypto-2024.zip'."
}

src_prepare() {
	sed -re '1s/(.*)/# \1/' -e '/.*scripts\/code-coverage.cmake.*/d' -i CMakeLists.txt || die
	sed -re '/ccsha2\/src\/ccsha256_trng_di\.c/d' -e 's|corecrypto_static/||' -i CoreCryptoSources.cmake || die
	# Contexts are arrays of a struct whose only member is "uint8_t state[1]",
	# and the fields live past it. cc_memcpy, cc_memmove and cc_memset check
	# against that one-byte subobject (__builtin_object_size mode 1), so with
	# _FORTIFY_SOURCE a copy into a digest context's buffer aborts. Check the
	# whole object instead.
	sed -e 's|__builtin_object_size((dst), 1)|__builtin_object_size((dst), 0)|' \
		-i cc/corecrypto/cc_priv.h || die
	cmake_src_prepare
}

src_test() {
	"${BUILD_DIR}/corecrypto_test" || die
}
