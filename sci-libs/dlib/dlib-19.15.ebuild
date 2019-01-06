# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )
DISTUTILS_OPTIONAL=1
inherit cmake-utils cuda distutils-r1

DESCRIPTION="Numerical and networking C++ library"
HOMEPAGE="http://dlib.net/"
SRC_URI="https://github.com/davisking/dlib/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cblas debug cuda examples gif jpeg lapack mkl png python sqlite static-libs test X"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# doc needs a bunch of deps not in portage

RDEPEND="
	cblas? ( virtual/cblas:= )
	cuda? ( dev-libs/cudnn:= )
	jpeg? ( virtual/jpeg:0= )
	lapack? ( virtual/lapack:= )
	mkl? ( sci-libs/mkl:= )
	png? ( media-libs/libpng:0= )
	python? ( ${PYTHON_DEPS} )
	sqlite? ( dev-db/sqlite:3= )
	X? ( x11-libs/libX11:= )"
DEPEND="${RDEPEND}
	python? (
		dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	)"

DOCS=( docs/README.txt )

src_prepare() {
	use cuda && cuda_src_prepare
	cmake-utils_src_prepare
	use python && distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDLIB_ENABLE_ASSERTS="$(usex debug)"
		-DDLIB_ENABLE_STACK_TRACE="$(usex debug)"
		-DDLIB_GIF_SUPPORT="$(usex gif)"
		-DDLIB_JPEG_SUPPORT="$(usex jpeg)"
		-DDLIB_PNG_SUPPORT="$(usex png)"
		-DDLIB_LINK_WITH_SQLITE3="$(usex sqlite)"
		-DDLIB_NO_GUI_SUPPORT="$(usex X OFF ON)"
		-DDLIB_USE_BLAS="$(usex cblas)"
		-DDLIB_USE_CUDA="$(usex cuda)"
		-DDLIB_USE_LAPACK="$(usex lapack)"
	)
	cmake-utils_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use python && distutils-r1_src_compile
}

python_test() {
	esetup.py test
}

src_test() {
	mkdir "${BUILD_DIR}"/dlib/test || die
	pushd "${BUILD_DIR}"/dlib/test > /dev/null || die
	cmake "${S}"/dlib/test && emake
	./dtest --runall || die
	popd > /dev/null || die
	use python && distutils-r1_src_test
}

src_install() {
	cmake-utils_src_install
	use python && distutils-r1_src_install
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/*.a
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}
	fi
}
