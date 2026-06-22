# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake python-single-r1 xdg

DESCRIPTION="Fast and minimalist 3D viewer"
HOMEPAGE="
	https://f3d.app/
	https://github.com/f3d-app/f3d
"
SRC_URI="https://github.com/f3d-app/f3d/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alembic assimp exr +hdf occt pdal python vdb webp"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# shellcheck disable=SC2016
RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/cxxopts
	media-libs/freetype
	>=sci-libs/vtk-9.5.2-r1[rendering]
	virtual/opengl
	alembic? ( media-gfx/alembic )
	assimp? ( >=media-libs/assimp-5.4.0 )
	exr? ( media-libs/openexr:= )
	hdf? ( sci-libs/vtk[netcdf] )
	occt? ( >=sci-libs/opencascade-7.6.3:= )
	pdal? ( sci-libs/vtk[pdal] )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]')
	)
	vdb? ( sci-libs/vtk[openvdb] )
	webp? ( media-libs/libwebp:= )
"
DEPEND="${RDEPEND}"

# media-libs/libwebp ships only pkg-config files, but f3d's WebP module looks
# for a CMake config providing WebP::webp. Patch it to use pkg-config instead.
PATCHES=( "${FILESDIR}/${P}-webp-pkgconfig.patch" )

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DF3D_BINDINGS_C=OFF
		-DF3D_BINDINGS_JAVA=OFF
		"-DF3D_BINDINGS_PYTHON=$(usex python)"
		-DF3D_BUILD_APPLICATION=ON
		"-DF3D_MODULE_EXR=$(usex exr)"
		-DF3D_MODULE_UI=ON
		"-DF3D_MODULE_WEBP=$(usex webp)"
		"-DF3D_PLUGIN_BUILD_ALEMBIC=$(usex alembic)"
		"-DF3D_PLUGIN_BUILD_ASSIMP=$(usex assimp)"
		"-DF3D_PLUGIN_BUILD_HDF=$(usex hdf)"
		"-DF3D_PLUGIN_BUILD_OCCT=$(usex occt)"
		"-DF3D_PLUGIN_BUILD_PDAL=$(usex pdal)"
		"-DF3D_PLUGIN_BUILD_VDB=$(usex vdb)"
		-DF3D_USE_EXTERNAL_CXXOPTS=ON
		-DF3D_USE_EXTERNAL_NLOHMANN_JSON=ON
	)
	use python && mycmakeargs+=( -DPython_EXECUTABLE="${PYTHON}" )
	cmake_src_configure
}
