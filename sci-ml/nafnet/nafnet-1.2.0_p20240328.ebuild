# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN="NAFNet"
MY_COMMIT="2b4af71ebe098a92a75910c233a3965a3e93ede4"

DESCRIPTION="Image restoration model without nonlinear activation functions."
HOMEPAGE="https://github.com/megvii-research/NAFNet"
SRC_URI="https://github.com/megvii-research/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

# NAFNet's own code is MIT. It is a fork of BasicSR, whose inherited parts are
# Apache-2.0, which is what setup.py still declares.
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/addict[${PYTHON_USEDEP}]
		dev-python/future[${PYTHON_USEDEP}]
		dev-python/lmdb[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		media-libs/opencv[python,${PYTHON_USEDEP}]
	')
	>=sci-ml/pytorch-2.1[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"

# The suite is a set of training and evaluation entry points that expect the
# datasets and pretrained checkpoints upstream hosts off-site.
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${P}-py313-exec-locals.patch"
	"${FILESDIR}/${P}-no-cuda-ext.patch"
	"${FILESDIR}/${P}-package-init.patch"
)

python_install_all() {
	# The YAML option files name the architecture, weights and dataset for
	# each task and are what the scripts under basicsr/ are driven by.
	insinto "/usr/share/${PN}"
	doins -r options

	distutils-r1_python_install_all
}

pkg_postinst() {
	elog "This installs upstream's fork of BasicSR, so the importable module is"
	elog "called basicsr rather than nafnet."
	elog
	elog "No pretrained weights are included. Fetch the checkpoint for the task"
	elog "you want from the links in the upstream README and point the YAML in"
	elog "/usr/share/doc/${PF}/options at it."
	elog
	elog "Logging to TensorBoard additionally needs the tensorboard module,"
	elog "which is imported only when that logger is switched on."
}
