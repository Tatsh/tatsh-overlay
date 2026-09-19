# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake cuda

MY_PN="trellis.cpp"
# thirdparty/ggml is a submodule pointing at a fork carrying the patches this
# needs, so sci-ml/ggml cannot be used in its place.
GGML_COMMIT="737e88f25d4f62254f3b7a726fd9663036cc94da"
# The weights upstream's install/install.sh downloads, pinned to a revision so
# the distfiles are immutable (the repository has no tags, only a moving main).
WEIGHTS_COMMIT="a57397bd3d351599d9729fc144b3f87c3f87d65b"
WEIGHTS_HF="https://huggingface.co/ilintar/trellis2-gguf/resolve/${WEIGHTS_COMMIT}"
WEIGHTS_P="trellis2-gguf-${WEIGHTS_COMMIT:0:8}"
# The q4/ and q8/ subdirectories ship these two byte for byte identical to the
# f16 ones, so they are fetched once regardless of the selected quantization.
WEIGHTS_SHARED=( birefnet ss_dec )
WEIGHTS_QUANT=(
	dinov3
	shape_dec
	shape_flow_512
	shape_flow_1024
	ss_flow
	tex_dec
	tex_flow_512
	tex_flow_1024
)

DESCRIPTION="TRELLIS.2 image to 3D in C++ and GGML."
HOMEPAGE="https://github.com/pwilkin/trellis.cpp"
SRC_URI="https://github.com/pwilkin/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz
	https://github.com/pwilkin/ggml/archive/${GGML_COMMIT}.tar.gz
	-> ggml-${GGML_COMMIT}.gh.tar.gz"
for _w in "${WEIGHTS_SHARED[@]}"; do
	SRC_URI+=" ${WEIGHTS_HF}/${_w}.gguf -> ${WEIGHTS_P}-${_w}.gguf"
done
for _q in f16 q4 q8; do
	# f16 is the top level of the repository, the quantizations are subdirectories.
	_d="${_q}/"
	[[ ${_q} == f16 ]] && _d=""
	SRC_URI+=" weights-${_q}? ("
	for _w in "${WEIGHTS_QUANT[@]}"; do
		SRC_URI+=" ${WEIGHTS_HF}/${_d}${_w}.gguf -> ${WEIGHTS_P}-${_q}-${_w}.gguf"
	done
	SRC_URI+=" )"
done
unset -v _d _q _w
S="${WORKDIR}/${MY_PN}-${PV}"

# The GGUF repository declares "license: other - see the source model", and that
# source model (microsoft/TRELLIS-image-large) is MIT, same as the code.
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cuda vulkan +webp weights-f16 weights-q4 weights-q8"
REQUIRED_USE="?? ( weights-f16 weights-q4 weights-q8 )"

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

src_unpack() {
	# Only the two tarballs; the weights are installed straight from DISTDIR.
	unpack "${P}.gh.tar.gz" "ggml-${GGML_COMMIT}.gh.tar.gz"
}

src_prepare() {
	rmdir thirdparty/ggml || die
	mv "${WORKDIR}/ggml-${GGML_COMMIT}" thirdparty/ggml || die

	# trellis-cli and trellis-server share this one default, and it is relative
	# ("models"), so without this they only work from one directory.
	grep -q 'std::string models = "models";' include/trellis_args.h ||
		die "the models directory default moved, update this sed"
	sed -i -e "s|std::string models = \"models\";|std::string models = \"${EPREFIX}/usr/share/${PN}/models\";|" \
		include/trellis_args.h || die

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

	# Installed under the names the loader looks for, straight from DISTDIR:
	# these are multi-gigabyte files and copying them through WORKDIR first is
	# pointless.
	local quant="" w
	for w in f16 q4 q8; do
		use "weights-${w}" && quant="${w}"
	done
	if [[ -n ${quant} ]]; then
		insinto "/usr/share/${PN}/models"
		for w in "${WEIGHTS_SHARED[@]}"; do
			newins "${DISTDIR}/${WEIGHTS_P}-${w}.gguf" "${w}.gguf"
		done
		for w in "${WEIGHTS_QUANT[@]}"; do
			newins "${DISTDIR}/${WEIGHTS_P}-${quant}-${w}.gguf" "${w}.gguf"
		done
	fi

	einstalldocs
}

pkg_postinst() {
	if use weights-f16 || use weights-q4 || use weights-q8; then
		elog "The TRELLIS.2 weights are installed in"
		elog "  ${EROOT}/usr/share/${PN}/models"
		elog "and trellis-cli and trellis-server read them from there by default."
		elog "Pass --models DIR to use a different set, and switch quantization"
		elog "with the weights-f16, weights-q8 and weights-q4 USE flags."
	else
		ewarn "No TRELLIS.2 weights are installed, so trellis-cli and"
		ewarn "trellis-server will not run. Either enable one of the"
		ewarn "weights-q8 (~10 GB), weights-q4 (~6 GB) or weights-f16 (~16 GB)"
		ewarn "USE flags, or put the GGUF files from"
		ewarn "  https://huggingface.co/ilintar/trellis2-gguf"
		ewarn "in ${EROOT}/usr/share/${PN}/models yourself (--models DIR"
		ewarn "overrides that path)."
	fi
	elog
	elog "Upstream's Tauri front end under app/ is not built or installed."
}
