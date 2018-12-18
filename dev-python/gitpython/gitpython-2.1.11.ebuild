# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
inherit distutils-r1

DESCRIPTION="GitPython is a Python library used to interact with Git repositories."
HOMEPAGE="https://gitpython.readthedocs.io/"
SRC_URI="https://files.pythonhosted.org/packages/4d/e8/98e06d3bc954e3c5b34e2a579ddf26255e762d21eb24fede458eff654c51/GitPython-2.1.11.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/gitdb2"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/GitPython-${PV}"
