# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library manager for C/C++ (tool only)."
HOMEPAGE="https://github.com/microsoft/vcpkg-tool https://vcpkg.io/en/index.html"
MY_PV="${PV//./-}"
FMT_PV=11.0.2
SRC_URI="https://github.com/microsoft/${PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/fmtlib/fmt/archive/${FMT_PV}.tar.gz -> libfmt-${FMT_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# For future use (and remove libfmt from SRC_URI):
# DEPEND=">=dev-libs/libfmt-10.1.0:="
# RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmakerc"

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=( "${FILESDIR}/${PN}-fmt.patch" )

src_prepare() {
	mv "${WORKDIR}/fmt-${FMT_PV}" "${S}/" || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_TESTING=$(usex test)"
		"-DVCPKG_DEPENDENCY_EXTERNAL_FMT_SRC_DIR=fmt-${FMT_PV}"
		"-DVCPKG_STANDALONE_BUNDLE_SHA=$(grep -E 'VCPKG_STANDALONE_BUNDLE_SHA"' CMakePresets.json | cut '-d"' -f4)"
		-DBUILD_SHARED_LIBS=OFF
		-DFMT_INSTALL=OFF
		-DVCPKG_BASE_VERSION=2024-01-11
		-DVCPKG_BUILD_TLS12_DOWNLOADER=OFF
		-DVCPKG_DEPENDENCY_CMAKERC=ON
		-DVCPKG_DEPENDENCY_EXTERNAL_FMT_SRC=ON
		-DVCPKG_DEVELOPMENT_WARNINGS=OFF
		-DVCPKG_EMBED_GIT_SHA=OFF
		-DVCPKG_OFFICIAL_BUILD=ON
		-DVCPKG_WARNINGS_AS_ERRORS=OFF
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	einfo
	einfo 'To use vcpkg you need to have a copy of https://github.com/microsoft/vcpkg'
	einfo 'or another root somewhere and point to it with the VCPKG_ROOT environment'
	einfo 'variable or by passing --vcpkg-root=<path>.'
	einfo
}
