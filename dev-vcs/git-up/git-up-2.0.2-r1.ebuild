# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/GitPython-3.1.8
	>=dev-python/colorama-0.3.7
	>=dev-python/termcolor-1.1.0
	>=dev-python/six-1.10.0"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/remove-click-dep.patch" )

src_prepare() {
	default
	sed -r -e "/'click>=7.0,<8.0',/d" -i setup.py
}
