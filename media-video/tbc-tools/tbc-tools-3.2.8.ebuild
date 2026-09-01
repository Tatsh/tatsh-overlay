# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake python-single-r1 xdg

DESCRIPTION="Post decoder tools for the decode projects' TBC format."
HOMEPAGE="https://github.com/harrypm/tbc-tools"
# Both are git submodules, so they are absent from the GitHub archive.
EZPWD_SHA="62a490c13f6e057fbf2dc6777fde234c7a19098e"
CC_DECODER_SHA="3dc59562c20ade687c524d9f4510a55a836ca475"
SRC_URI="https://github.com/harrypm/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz
	https://github.com/pjkundert/ezpwd-reed-solomon/archive/${EZPWD_SHA}.tar.gz
	-> ${PN}-ezpwd-${EZPWD_SHA:0:8}.gh.tar.gz
	https://github.com/eshaz/cc_decoder/archive/${CC_DECODER_SHA}.tar.gz
	-> ${PN}-cc_decoder-${CC_DECODER_SHA:0:8}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="teletext"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# ld-chroma-decoder requires ONNX Runtime unconditionally; upstream provides no
# option to build without it.
DEPEND="dev-qt/qtbase:6[gui,sql,widgets]
	dev-qt/qtsvg:6
	sci-libs/fftw:3.0=
	|| ( sci-libs/onnxruntime sci-libs/onnxruntime-bin )"
# tbc-video-export is a bundled Python application driving ffmpeg, and
# ld-process-vbi shells out to the bundled vhs-teletext for teletext export.
# shellcheck disable=SC2016
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	media-video/ffmpeg
	$(python_gen_cond_dep '
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		teletext? (
			dev-python/click[${PYTHON_USEDEP}]
			dev-python/matplotlib[${PYTHON_USEDEP}]
			dev-python/numpy[${PYTHON_USEDEP}]
			dev-python/pyzmq[${PYTHON_USEDEP}]
			dev-python/scipy[${PYTHON_USEDEP}]
			dev-python/tqdm[${PYTHON_USEDEP}]
		)
	')"

PATCHES=(
	"${FILESDIR}/${P}-no-install-cache-update.patch"
	"${FILESDIR}/${P}-vendor-datadir.patch"
)

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	rmdir src/efm-decoder/libs/ezpwd src/ld-process-vbi/vendor/cc_decoder || die
	mv "${WORKDIR}/ezpwd-reed-solomon-${EZPWD_SHA}" src/efm-decoder/libs/ezpwd || die
	mv "${WORKDIR}/cc_decoder-${CC_DECODER_SHA}" src/ld-process-vbi/vendor/cc_decoder || die
	# Both bundled Python applications hunt for an interpreter on PATH. Only the
	# one selected here is guaranteed to have the dependencies installed.
	sed -i "s|^PYTHON_NAMES=(.*)$|PYTHON_NAMES=(${EPYTHON} python3 python)|" \
		src/tbc-video-export/tbc-video-export.in || die
	sed -i "s|QStringLiteral(\"python3\"),|QStringLiteral(\"${EPYTHON}\"),\n        QStringLiteral(\"python3\"),|" \
		src/ld-process-vbi/teletextintegration.cpp || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# ld-decode's Python library is provided by media-video/vhs-decode.
		-DBUILD_PYTHON=OFF
		# sci-libs/onnxruntime{,-bin} install their headers straight into
		# /usr/include, but the onnxruntimeTargets.cmake they ship points
		# INTERFACE_INCLUDE_DIRECTORIES at /usr/include/onnxruntime, which does
		# not exist and makes CMake reject the imported target. Skip the config
		# package and let upstream's own path search find things instead.
		-DCMAKE_DISABLE_FIND_PACKAGE_onnxruntime=ON
		"-DONNXRUNTIME_ROOT=${EPREFIX}/usr"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if ! use teletext; then
		rm -r "${ED}/usr/share/${PN}/vendor/vhs-teletext" || die
	fi
}
