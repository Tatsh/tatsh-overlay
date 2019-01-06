# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="The world's simplest facial recognition API for Python and the command line."
HOMEPAGE="https://github.com/ageitgey/face_recognition"
SRC_URI="https://files.pythonhosted.org/packages/a3/f3/99c0fdebe04ab2ed12a6b9a6b6c568a6ae9c757da700215a24aaa8ab9070/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/face_recognition_models-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/click-6.0[${PYTHON_USEDEP}]
	>=sci-libs/dlib-19.7[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND=""
