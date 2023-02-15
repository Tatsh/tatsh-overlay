# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_IN_SOURCE_BUILD=-1
inherit cmake distutils-r1

DESCRIPTION="Editorial interchange format and API (for use with Kdenlive)."
HOMEPAGE="https://pypi.org/project/OpenTimelineIO/ https://github.com/AcademySoftwareFoundation/OpenTimelineIO"
MY_PN="OpenTimelineIO"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/pyside2[${PYTHON_USEDEP}]
	dev-libs/imath
	dev-python/pyaaf2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	sed -re '/.*: OTIO_build_ext,/d' -i setup.py
	distutils-r1_python_prepare_all
}

python_prepare() {
	cmake_src_prepare
}

python_configure() {
	local mycmakeargs=(
		-DOTIO_AUTOMATIC_SUBMODULES=OFF
		-DOTIO_DEPENDENCIES_INSTALL=OFF
		-DOTIO_FIND_IMATH=ON
		-DOTIO_INSTALL_COMMANDLINE_TOOLS=$(usex tools)
		-DOTIO_INSTALL_CONTRIB=OFF
		-DOTIO_INSTALL_PYTHON_MODULES=OFF
		-DOTIO_PYTHON_INSTALL=ON
		-DOTIO_SHARED_LIBS=OFF
		-DPython_EXECUTABLE=${PYTHON}
		-DOTIO_PYTHON_INSTALL_DIR=$(python_get_sitedir)
	)
	cmake_src_configure
}

python_compile() {
	cmake_src_compile
	distutils-r1_python_compile
}

python_install() {
	cmake_src_install
	distutils-r1_python_install
}
