# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="A dynamic recompiler for ARM."
HOMEPAGE="https://github.com/MerryMage/dynarmic"
MY_SHA="8d1699ba2db216e569e998ea318d5cde47720e97"
SRC_URI="https://github.com/MerryMage/${PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libfmt:0/7
	dev-cpp/catch:0
	dev-libs/mp
	>=dev-libs/xbyak-5.941"
RDEPEND="${DEPEND}"
BDEPEND=">=sys-devel/clang-10"

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=(
	"${FILESDIR}/${PN}-include-path-fixes.patch"
	"${FILESDIR}/${PN}-cmake-fixes.patch"
	"${FILESDIR}/${PN}-system-xbyak.patch"
)

src_configure() {
	CC=${CHOST}-clang
	CXX=${CHOST}-clang++
	local mycmakeargs=(
		-DDYNARMIC_TESTS=OFF
		-DDYNARMIC_FRONTENDS="A32"
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake-utils_src_configure
}

src_install() {
	einstalldocs
	dolib.a "${BUILD_DIR}/src/lib${PN}.a"
	insinto /usr/include
	doins -r include/${PN}
}
