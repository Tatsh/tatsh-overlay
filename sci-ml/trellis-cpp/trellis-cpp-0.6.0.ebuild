# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake cuda

MY_PN="trellis.cpp"
# thirdparty/ggml is a submodule pointing at a fork carrying the patches this
# needs, so sci-ml/ggml cannot be used in its place.
GGML_COMMIT="737e88f25d4f62254f3b7a726fd9663036cc94da"

DESCRIPTION="TRELLIS.2 image to 3D in C++ and GGML."
HOMEPAGE="https://github.com/pwilkin/trellis.cpp"
SRC_URI="https://github.com/pwilkin/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz
	https://github.com/pwilkin/ggml/archive/${GGML_COMMIT}.tar.gz
	-> ggml-${GGML_COMMIT}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cuda vulkan +webp"

RDEPEND="
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	vulkan? ( media-libs/vulkan-loader )
	webp? ( media-libs/libwebp:= )
"
DEPEND="
	${RDEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="
	virtual/pkgconfig
	vulkan? ( dev-util/glslang )
"

PATCHES=( "${FILESDIR}/${PN}-system-libwebp.patch" )

src_prepare() {
	rmdir thirdparty/ggml || die
	mv "${WORKDIR}/ggml-${GGML_COMMIT}" thirdparty/ggml || die

	use cuda && cuda_src_prepare

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DGGML_CUDA=$(usex cuda)"
		-DGGML_NATIVE=OFF
		"-DGGML_VULKAN=$(usex vulkan)"
		"-DTRELLIS_WEBP=$(usex webp)"
	)

	if use cuda; then
		# nvcc refuses a host compiler newer than the toolkit knows about, and
		# the default one usually is. Build the whole thing with the newest gcc
		# cuda_gccdir reports as supported rather than only the CUDA sources,
		# so that one compiler and one set of flags apply throughout.
		local cuda_bindir
		cuda_bindir="$(cuda_gccdir)" || die "cuda_gccdir failed"
		export CUDAHOSTCXX="${cuda_bindir}/g++"
		export NVCC_CCBIN="${CUDAHOSTCXX}"
		export CC="${cuda_bindir}/gcc" CXX="${CUDAHOSTCXX}"

		mycmakeargs+=( -DCMAKE_CUDA_HOST_COMPILER="${CUDAHOSTCXX}" )
	fi

	cmake_src_configure
}

src_install() {
	# Upstream defines no install rules, and the executables are linked with an
	# RPATH of $ORIGIN so that ggml's shared libraries are found beside them.
	# Keeping that arrangement under libexec is cheaper than relinking, and the
	# symlinks still resolve because $ORIGIN follows the real path.
	exeinto "/usr/libexec/${PN}"
	doexe "${BUILD_DIR}/trellis-cli" "${BUILD_DIR}/trellis-server"

	local lib
	for lib in "${BUILD_DIR}"/libggml*.so*; do
		[[ -f ${lib} ]] || continue
		doexe "${lib}"
	done

	dosym "../libexec/${PN}/trellis-cli" /usr/bin/trellis-cli
	dosym "../libexec/${PN}/trellis-server" /usr/bin/trellis-server

	einstalldocs
}

pkg_postinst() {
	elog "The TRELLIS.2 weights are not distributed with this package. Point"
	elog "trellis-cli at a directory of GGUF conversions of them with --models;"
	elog "see https://github.com/pwilkin/trellis.cpp for what it expects."
	elog
	elog "Upstream's Tauri front end under app/ is not built or installed."
}
