# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Harwell Solver Library (HSL)."
HOMEPAGE="https://github.com/coin-or-tools/ThirdParty-HSL https://licences.stfc.ac.uk/product/coin-hsl"
BUILD_TOOLS_VERSION="20208f47f7bbc0056a92adefdfd43fded969f674"
SOLVERS_VERSION="1.0.1"
COINHSL_ARCHIVE_PV="2024.05.15"
COINHSL_ARCHIVE_P="coinhsl-archive-${COINHSL_ARCHIVE_PV}"
SRC_URI="mirror+https://github.com/coin-or-tools/ThirdParty-HSL/archive/refs/tags/releases/${PV}.tar.gz -> ${P}.tar.gz
	mirror+https://github.com/coin-or-tools/BuildTools/archive/${BUILD_TOOLS_VERSION}.tar.gz -> coin-or-tools-BuildTools-${BUILD_TOOLS_VERSION}.tar.gz
	${COINHSL_ARCHIVE_P}.tar.gz"
RESTRICT="fetch"
S="${WORKDIR}/ThirdParty-HSL-releases-${PV}"

LICENSE="EPL-2.0 HSL-Academic-Licence"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="sci-libs/lapack"
BDEPEND="virtual/fortran"

pkg_nofetch() {
	einfo "You must obtain coinhsl-archive-2024.05.15.tar.gz from"
	einfo "https://licences.stfc.ac.uk/product/coin-hsl-archive (requires registration) and place"
	einfo "it in your DISTDIR directory."
	einfo "Other versions of HSL are not supported at this time."
}

src_prepare() {
	default
	AT_M4DIR="${WORKDIR}/BuildTools-${BUILD_TOOLS_VERSION}"
	mv "../${COINHSL_ARCHIVE_P}" "${PN}"
	eautoreconf
}

src_configure() {
	econf --enable-shared
}

src_install() {
	default
	rm "${D}/usr/$(get_libdir)/lib${PN}.la" || die
	dosym -r "/usr/$(get_libdir)/lib${PN}.so" "/usr/$(get_libdir)/libhsl.so"
}
