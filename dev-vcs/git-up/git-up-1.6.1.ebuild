# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SRC_URI="https://files.pythonhosted.org/packages/46/45/32dc0bf07c620644a8ed899e381309f4f25b50f20a91e555285522592833/git-up-1.6.1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/GitPython-2.1.1
>=dev-python/colorama-0.3.7
>=dev-python/termcolor-1.1.0
>=dev-python/click-7.0
>=dev-python/six-1.10.0"
DEPEND="${RDEPEND}"
