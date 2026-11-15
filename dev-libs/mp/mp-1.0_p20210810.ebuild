# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A small, 0BSD-licensed metaprogramming library for C++17"
HOMEPAGE="https://github.com/merryhime/mp"
SHA="b50053cef50385419c59fb3aebb78974547318bc"
SRC_URI="https://github.com/merryhime/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${SHA}"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="dev-libs/gmp dev-libs/mpfr"
RDEPEND="${DEPEND}"

src_test() {
	# The tests are static_asserts; building the program is the check.
	# shellcheck disable=SC2086
	"$(tc-getCXX)" ${CPPFLAGS} ${CXXFLAGS} -std=c++17 -Iinclude ${LDFLAGS} \
		tests/all_tests.cpp -o "${T}/all_tests" || die
	"${T}/all_tests" || die
}

src_install() {
	insinto /usr/include
	doins -r include/mp
	einstalldocs
}
