# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CRATES="
	approx@0.5.1
	autocfg@1.5.0
	either@1.15.0
	gaussfilt@0.1.3
	heck@0.5.0
	itertools@0.13.0
	itertools@0.14.0
	kalmanfilt@0.3.0
	libc@0.2.184
	libm@0.2.16
	lstsq@0.6.0
	matrixmultiply@0.3.10
	nalgebra@0.33.3
	ndarray@0.16.1
	ndarray@0.17.2
	num-complex@0.4.6
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	numpy@0.28.0
	once_cell@1.21.4
	paste@1.0.15
	portable-atomic@1.13.1
	portable-atomic-util@0.2.6
	proc-macro2@1.0.106
	pyo3@0.28.3
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros@0.28.3
	pyo3-macros-backend@0.28.3
	quote@1.0.45
	rawpointer@0.2.1
	rustc-hash@2.1.2
	sci-rs@0.4.1
	simba@0.9.1
	syn@2.0.117
	target-lexicon@0.13.5
	typenum@1.19.0
	unicode-ident@1.0.24
"
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{2,3,4} )
inherit cargo desktop distutils-r1

DESCRIPTION="Software defined VHS decoder."
HOMEPAGE="https://github.com/oyvindln/vhs-decode"
SRC_URI="https://github.com/oyvindln/vhs-decode/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"
LICENSE="GPL-3 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk"

# As of 0.4.0 the C++ TBC tools live in media-video/tbc-tools; what remains
# here is the Python and Rust decoder suite.
DEPEND="sci-libs/fftw"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/soxr[${PYTHON_USEDEP}]
	media-video/ffmpeg
	dev-python/scipy[${PYTHON_USEDEP}]
	gtk? ( dev-python/gooey[${PYTHON_USEDEP}] )
	dev-python/av[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/noisereduce[${PYTHON_USEDEP}]
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/samplerate[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/sounddevice[${PYTHON_USEDEP}]
	dev-python/soundfile[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython:0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED=".*/_rust.*"

src_prepare() {
	eapply "${FILESDIR}/${PN}-remove-cc-hardcodes.patch"
	distutils-r1_src_prepare
}

src_compile() {
	export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_vhs_decode=${PV}
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	if use gtk; then
		dobin "${PN}-gui"
		make_desktop_entry "${PN}-gui" "VHS decode" "camera-video"
	fi
	rm -rf "${D}/usr/lib/python"*"/site-packages/UNKNOWN"*.dist-info || die
}
