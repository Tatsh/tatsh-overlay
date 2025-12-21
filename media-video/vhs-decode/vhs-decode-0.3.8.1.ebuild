# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CRATES="approx@0.5.1
	autocfg@1.5.0
	either@1.15.0
	gaussfilt@0.1.3
	heck@0.5.0
	indoc@2.0.7
	itertools@0.13.0
	itertools@0.14.0
	kalmanfilt@0.3.0
	libc@0.2.178
	libm@0.2.15
	lstsq@0.6.0
	matrixmultiply@0.3.10
	memoffset@0.9.1
	nalgebra@0.33.2
	ndarray@0.16.1
	ndarray@0.17.1
	num-complex@0.4.6
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	numpy@0.27.1
	once_cell@1.21.3
	paste@1.0.15
	portable-atomic-util@0.2.4
	portable-atomic@1.11.1
	proc-macro2@1.0.103
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3-macros-backend@0.27.2
	pyo3-macros@0.27.2
	pyo3@0.27.2
	quote@1.0.42
	rawpointer@0.2.1
	rustc-hash@2.1.1
	rustversion@1.0.22
	sci-rs@0.4.1
	simba@0.9.1
	syn@2.0.111
	target-lexicon@0.13.3
	typenum@1.19.0
	unicode-ident@1.0.22
	unindent@0.2.4"
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
inherit cargo cmake desktop distutils-r1

DESCRIPTION="Software defined VHS decoder."
HOMEPAGE="https://github.com/oyvindln/vhs-decode"
LD_DECODE_TESTDATA_REV="dd9569daee212dd3fea413c97372d2bf55aceba2"
SRC_URI="https://github.com/oyvindln/vhs-decode/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/happycube/ld-decode-testdata/archive/${LD_DECODE_TESTDATA_REV}.tar.gz -> ld-decode-testdata-${LD_DECODE_TESTDATA_REV:0:7}.tar.gz )
	${CARGO_CRATE_URIS}"
LICENSE="GPL-3 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk test"
RESTRICT="!test? ( test )"

DEPEND="x11-libs/qwt:6[qt6]
	dev-qt/qtbase:6
	sci-libs/fftw"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	media-video/ffmpeg
	dev-python/scipy[${PYTHON_USEDEP}]
	gtk? ( dev-python/gooey[${PYTHON_USEDEP}] )
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/samplerate[${PYTHON_USEDEP}]
	dev-python/sounddevice[${PYTHON_USEDEP}]
	dev-python/soundfile[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython:0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED=".*/_rust.*"

src_prepare() {
	sed -re 's/qwt-qt5 qwt6-qt5/qwt6-qt6/' -i cmake_modules/FindQwt.cmake || die
	eapply "${FILESDIR}/${PN}-force-find-package-qwt.patch"
	cmake_src_prepare
	eapply "${FILESDIR}/${PN}-remove-cc-hardcodes.patch"
	distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_TESTING=$(usex test)"
		-DUSE_QT_VERSION=6
	)
	cmake_src_configure
	distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_vhs_decode=${PV}
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
	rm -rf "${D}/usr/lib/python"*"/site-packages/UNKNOWN"*.dist-info || die
}

src_test() {
	ln -sf "../ld-decode-testdata-${LD_DECODE_TESTDATA_REV}" testdata || die
	local myctestargs=(-j 1)
	cmake_src_test
}
