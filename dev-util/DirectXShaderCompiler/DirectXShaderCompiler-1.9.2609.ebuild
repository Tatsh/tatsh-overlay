# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit check-reqs cmake flag-o-matic python-any-r1

DESCRIPTION="Microsoft DirectX Shader Compiler which is based on LLVM/Clang"
HOMEPAGE="https://github.com/microsoft/DirectXShaderCompiler"
# Submodules pinned by the release tag.
DIRECTX_HEADERS_SHA="980971e835876dc0cde415e8f9bc646e64667bf7"
SPIRV_HEADERS_SHA="496543121ce6419f23d6fa5d7194ba66c36212d2"
SPIRV_TOOLS_SHA="ef96ed763b43b59b33b31b362f09a02b729fa1c9"
SRC_URI="https://github.com/microsoft/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/microsoft/DirectX-Headers/archive/${DIRECTX_HEADERS_SHA}.tar.gz
		-> ${PN}-DirectX-Headers-${DIRECTX_HEADERS_SHA}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SPIRV_HEADERS_SHA}.tar.gz
		-> ${PN}-SPIRV-Headers-${SPIRV_HEADERS_SHA}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Tools/archive/${SPIRV_TOOLS_SHA}.tar.gz
		-> ${PN}-SPIRV-Tools-${SPIRV_TOOLS_SHA}.tar.gz"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA BSD public-domain rc"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libffi:=
	virtual/zlib:="
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

CHECKREQS_MEMORY="4G"
CHECKREQS_DISK_BUILD="4G"

pkg_setup() {
	check-reqs_pkg_setup
	python-any-r1_pkg_setup
}

src_prepare() {
	local dir
	for dir in DirectX-Headers SPIRV-Headers SPIRV-Tools; do
		rmdir "external/${dir}" || die
	done
	mv "${WORKDIR}/DirectX-Headers-${DIRECTX_HEADERS_SHA}" external/DirectX-Headers || die
	mv "${WORKDIR}/SPIRV-Headers-${SPIRV_HEADERS_SHA}" external/SPIRV-Headers || die
	mv "${WORKDIR}/SPIRV-Tools-${SPIRV_TOOLS_SHA}" external/SPIRV-Tools || die
	cmake_src_prepare
}

src_configure() {
	# The LLVM 3.7 base punned types in ways GCC flags as breaking strict aliasing.
	append-flags -fno-strict-aliasing
	local mycmakeargs=(
		-C "${S}/cmake/caches/PredefinedParams.cmake"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/dxc"
		# Regenerated sources are run through the system clang-format, whose output differs from
		# the checked-in copies, and the build then fails comparing them. Use the release's copies.
		-DHLSL_DISABLE_SOURCE_GENERATION=ON
		# The tests need the googletest submodule.
		-DHLSL_INCLUDE_TESTS=OFF
		-DLLVM_BUILD_DOCS=OFF
		-DLLVM_BUILD_TOOLS=OFF
		-DLLVM_ENABLE_WERROR=OFF
		-DLLVM_INCLUDE_TESTS=OFF
		-DLLVM_VERSION_SUFFIX=dxc
		-DSPIRV_BUILD_TESTS=OFF
		-DSPIRV_WARN_EVERYTHING=OFF
		-DSPIRV_WERROR=OFF
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# The static LLVM libraries and the CMake modules for building against them are not used by
	# dxc or libdxcompiler.so, and take up 1.6 GB.
	find "${ED}" -name '*.a' -delete || die
	rm -r "${ED}/usr/lib/llvm/dxc/share/llvm" || die
	newenvd - "99${PN}" <<-EOF
		LDPATH="${EPREFIX}/usr/lib/llvm/dxc/lib"
	EOF
	dosym -r /usr/lib/llvm/dxc/bin/dxc /usr/bin/dxc
}
