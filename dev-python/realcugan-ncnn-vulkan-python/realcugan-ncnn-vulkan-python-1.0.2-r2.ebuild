# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit cmake pypi python-r1

DESCRIPTION="A Python FFI of nihui/realcugan-ncnn-vulkan achieved with SWIG."
HOMEPAGE="https://pypi.org/project/realcugan-ncnn-vulkan-python/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn[vulkan]"
BDEPEND="dev-lang/swig dev-util/glslang"

MY_PN_U="${PN//-/_}"
S="${WORKDIR}/${P}/${MY_PN_U}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-fix-for-latest-glslang.patch"
)

src_prepare() {
	python_foreach_impl cmake_src_prepare
}

custom_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=$(python_get_sitedir)/${MY_PN_U}"
		"-DPY_VERSION=${EPYTHON:6}"
		-DBUILD_SHARED_LIBS=OFF
		-DCALL_FROM_SETUP_PY=ON
		-DUSE_SYSTEM_NCNN=ON
		-Wno-dev
	)
	cmake_src_configure
}

src_configure() {
	python_foreach_impl custom_configure
}

src_compile() {
	python_foreach_impl cmake_src_compile
}

custom_install() {
	cmake_src_install
	cp __init__.py "${D}/$(python_get_sitedir)/${MY_PN_U}/__init__.py" || die
	rm -f "${D}/$(python_get_sitedir)/${MY_PN_U}/LICENSE" || die
}

src_install() {
	python_foreach_impl custom_install
}
