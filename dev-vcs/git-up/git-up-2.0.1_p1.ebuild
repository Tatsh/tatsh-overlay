# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SRC_URI="https://files.pythonhosted.org/packages/6b/d6/177fc6cea5f34653fb9931e763d7b441ce35b0d7fbb95d5ac0e5e28f7a18/${PN}-2.0.1.post1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/GitPython-3.1.8
	>=dev-python/colorama-0.3.7
	>=dev-python/termcolor-1.1.0
	>=dev-python/click-7.0
	>=dev-python/six-1.10.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV:0:5}.post1"
