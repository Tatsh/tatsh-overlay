# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
# Upstream supports 3.11, but the onnxruntime bindings start at 3.12.
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Remove the background from images."
HOMEPAGE="https://github.com/danielgatis/rembg https://pypi.org/project/rembg/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# scikit-image is capped because upstream tracks its API breaks between minor
# releases. The Python bindings for the inference engine come from
# sci-libs/onnxruntime[python]; sci-libs/onnxruntime-bin is the C++ library
# alone and provides no importable module.
RDEPEND="
	<dev-python/scikit-image-0.27.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.1[${PYTHON_USEDEP}]
	>=dev-python/filetype-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.25.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-12.1.0[${PYTHON_USEDEP}]
	>=dev-python/pooch-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/pymatting-1.1.14[${PYTHON_USEDEP}]
	>=dev-python/scikit-image-0.26.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.16.3[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.67.1[${PYTHON_USEDEP}]
	>=dev-python/watchdog-6.0.0[${PYTHON_USEDEP}]
	>=sci-libs/onnxruntime-1.23.2[python,${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${P}-poetry-core.patch"
	"${FILESDIR}/${P}-optional-server.patch"
)

pkg_postinst() {
	elog "The models are not shipped with this package. rembg downloads the"
	elog "one it needs on first use and caches it under ~/.u2net."
	elog
	elog "The 's' command, which serves an HTTP API and a web UI, needs gradio"
	elog "and asyncer. Neither is packaged, so that one command is unavailable;"
	elog "everything else, including the library, works."
}
