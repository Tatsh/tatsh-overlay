# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Toolchain development library"
HOMEPAGE="https://github.com/jakcron/libtoolchain"
SRC_URI="https://github.com/jakcron/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libfmt net-libs/mbedtls"
RDEPEND="${DEPEND}"

PATCHES=(
	# mbedtls 2.28+ needs a completed context and an RNG (for blinding) for
	# private-key operations, so every RSA signature failed.
	"${FILESDIR}/${PN}-rsa-private-key.patch"
	# Strings were read up to a NUL that mbedtls 2.28+ no longer leaves behind.
	"${FILESDIR}/${PN}-base64-string-length.patch"
)

src_prepare() {
	# shellcheck disable=SC2016
	sed -re 's/@\$\(C(XX|C)/$(C\1/g' -i makefile || die
	default
}

src_compile() {
	emake static_lib
}

src_test() {
	# The makefile links -lmbedtls alone; system mbedtls splits out x509 and crypto.
	emake test_program LIB="-lmbedtls -lmbedx509 -lmbedcrypto -lfmt"
	# The runner exits 0 even when tests fail.
	"bin/${PN}_test" | tee "${T}/test.log" || die
	grep -q ': FAIL' "${T}/test.log" && die "Tests failed"
}

src_install() {
	dolib.a "bin/${PN}.a"
	insinto /usr/include
	doins -r include/*
	einstalldocs
}
