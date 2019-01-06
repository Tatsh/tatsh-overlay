# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="This package contains only the models used by face_recognition."
HOMEPAGE="https://pypi.org/project/face_recognition_models/"
SRC_URI="https://files.pythonhosted.org/packages/cf/3b/4fd8c534f6c0d1b80ce0973d01331525538045084c73c153ee6df20224cf/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	sci-libs/dlib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
