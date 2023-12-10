# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit cmake desktop distutils-r1

DESCRIPTION="Software defined VHS decoder."
HOMEPAGE="https://github.com/oyvindln/vhs-decode"
SHA="7bcec495043cf745b61cf459969f9810f6511726"
LD_DECODE_TESTDATA_SHA="eeddec3e9040f2110a3fcad5cadb45a3b733dee9"
SRC_URI="https://github.com/oyvindln/vhs-decode/archive/${SHA}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/happycube/ld-decode-testdata/archive/${LD_DECODE_TESTDATA_SHA}.tar.gz -> ld-decode-testdata-${LD_DECODE_TESTDATA_SHA:0:7}.tar.gz )"
IUSE="gtk test"
RESTRICT="!test? ( test )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/qwt:6
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtgui:5
	dev-qt/qtconcurrent:5
	dev-qt/qtopengl:5
	dev-qt/qtsvg:5
	sci-libs/fftw"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	media-video/ffmpeg
	dev-python/scipy[${PYTHON_USEDEP}]
	gtk? ( dev-python/gooey[${PYTHON_USEDEP}] )
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/samplerate[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/pyhht[${PYTHON_USEDEP}]
	<dev-python/soundfile-0.11.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython:0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	cmake_src_prepare
	sed -re 's/Qt\$\{QT_VERSION_MAJOR\}Qwt6/qwt6-qt5/g' -i CMakeLists.txt || die
	rm pyproject.toml || die
	distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_TESTING=$(usex test)"
		-DUSE_QT_VERSION=5
	)
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
	make_desktop_entry ld-analyse ld-analyse ld-analyse 'AudioVideo;Video'
}

src_test() {
	ln -sf "../ld-decode-testdata-${LD_DECODE_TESTDATA_SHA}" testdata || die
	local myctestargs=(-j 1)
	cmake_src_test
}
