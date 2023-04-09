# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools flag-o-matic

DESCRIPTION="A powerful tool to check TSS signing status of various devices and firmwares."
HOMEPAGE="https://github.com/tihmstar/tsschecker"
COMMIT_COUNT="319"
SHA="523ef11589d4b8c5ae17779c7071babdb080335f"
JSSY_SHA="e17d3c8ec5216692efbbe59bbe9801bb7661e07d"
SRC_URI="https://github.com/tihmstar/tsschecker/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/tihmstar/jssy/archive/${JSSY_SHA}.tar.gz -> ${P}-jssy.tar.gz"

# jssy is MIT
LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND=">=dev-libs/libfragmentzip-48
	>=app-pda/libplist-2.2.0
	net-misc/curl
	dev-libs/openssl:0
	>=app-pda/libirecovery-1.0.0
	dev-libs/tihmstar-libgeneral
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/clang"

PATCHES=( "${FILESDIR}/${PN}-0001-include-fixes.patch" )

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	default
	local -r quoted_commit_count='"'"${COMMIT_COUNT}"'"'
	local -r quoted_sha='"'"${SHA}"'"'
	sed -r \
		-e "s/^AC_INIT\(\[tsschecker\], m4_esyscmd.*/AC_INIT([${PN}], [${PV}], [tihmstar@gmail.com])/" \
		-e "s/^AC_DEFINE\(\[VERSION_COMMIT_COUNT], .*/AC_DEFINE([VERSION_COMMIT_COUNT], ${quoted_commit_count}, [Git commit count])/" \
		-e "s/^AC_DEFINE\(\[VERSION_COMMIT_SHA\], .*/AC_DEFINE([VERSION_COMMIT_SHA], ${quoted_sha}, [Git commit sha])/" \
		-e "s/^AC_SUBST\(\[VERSION_COMMIT_COUNT\], .*/AC_SUBST([VERSION_COMMIT_COUNT], [${quoted_commit_count}])/" \
		-e "s/^AC_SUBST\(\[VERSION_COMMIT_SHA\], .*/AC_SUBST([VERSION_COMMIT_SHA], [${quoted_sha}])/" \
		-i configure.ac || die
	eautoreconf
	mkdir -p "${S}/external/jssy" || die
	cp -R "${WORKDIR}/jssy-${JSSY_SHA}/"* "${S}/external/jssy/" || die
}

src_configure() {
	export CC=${CHOST}-clang
	export CXX=${CHOST}-clang++
	strip-unsupported-flags
	default
}

src_install() {
	default
	einstalldocs
	rm "${D}/usr/$(get_libdir)/lib${PN}.la" || die
}
