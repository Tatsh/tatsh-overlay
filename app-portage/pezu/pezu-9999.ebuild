# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3

DESCRIPTION="Helper commands to automate updating with Portage."
HOMEPAGE="https://github.com/Tatsh/pezu"
EGIT_REPO_URI="https://github.com/Tatsh/pezu"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
