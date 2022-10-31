# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )

inherit cmake desktop distutils-r1

DESCRIPTION="Software defined VHS decoder."
HOMEPAGE="https://github.com/oyvindln/vhs-decode"
SHA="356723e42204c2c5e492fe1c21811af8d76e8ac8"
SRC_URI="https://github.com/oyvindln/vhs-decode/archive/${SHA}.tar.gz -> ${P}.tar.gz"
IUSE="gtk"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/qwt:6
	dev-qt/qtcore:=
	dev-qt/qtwidgets:=
	dev-qt/qtprintsupport:=
	dev-qt/qtgui:=
	dev-qt/qtconcurrent:=
	dev-qt/qtopengl:=
	dev-qt/qtsvg:=
	sci-libs/fftw"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	media-video/ffmpeg
	dev-python/scipy[${PYTHON_USEDEP}]
	gtk? ( dev-python/gooey[${PYTHON_USEDEP}] )
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/samplerate[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython:0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	cmake_src_prepare
	rm pyproject.toml || die
	distutils-r1_src_prepare
}

src_configure() {
	cmake_src_configure
	distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	distutils-r1_src_compile
}

src_install() {
	local size
	cmake_src_install
	distutils-r1_src_install
	if use gtk; then
		dobin "${PN}-gui"
		make_desktop_entry "${PN}-gui" "VHS decode" "camera-video"
	fi
	for size in 256 128 64; do
		newicon -s "${size}" "tools/ld-analyse/Graphics/${size}-analyse.png" ld-analyse.png
	done
	make_desktop_entry ld-analyse ld-analyse ld-analyse Video
}
