# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit cmake python-any-r1

MY_PN=SPIRV-Cross

DESCRIPTION="Tool and library for parsing SPIR-V and converting it to other shader languages"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Cross"
SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/refs/tags/vulkan-sdk-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-vulkan-sdk-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# The reference outputs are produced with the glslang and SPIRV-Tools of the
# same Vulkan SDK release.
BDEPEND="test? (
	${PYTHON_DEPS}
	~dev-util/glslang-${PV}
	~dev-util/spirv-tools-${PV}
)"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DSPIRV_CROSS_ENABLE_TESTS="$(usex test)"
		-DSPIRV_CROSS_SHARED=ON
		-DSPIRV_CROSS_WERROR=OFF
	)
	# Upstream looks for the tools only in its own checkout under external/.
	use test && mycmakeargs+=(
		-Dspirv-cross-glslang="${BROOT}/usr/bin/glslangValidator"
		-Dspirv-cross-spirv-as="${BROOT}/usr/bin/spirv-as"
		-Dspirv-cross-spirv-opt="${BROOT}/usr/bin/spirv-opt"
		-Dspirv-cross-spirv-val="${BROOT}/usr/bin/spirv-val"
	)
	cmake_src_configure
}

src_test() {
	# These compare output with references made with glslang and SPIRV-Tools
	# from 153 commits before the vulkan-sdk-${PV} tags, and a few shaders now
	# compile differently.
	local myctestargs=( -E '^spirv-cross-test(-metal|-hlsl)?(-opt|-no-opt)?$' )
	cmake_src_test
}
