# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Syncs all GitHub fork default branches against upstream"
HOMEPAGE="http://pypi.python.org/pypi/sync-github-forks/"
SRC_URI="https://pypi.python.org/packages/source/s/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/osextension-0.1.2
	>=dev-python/PyGithub-1.25.0
	>=dev-python/pyyaml-3.10
	>=dev-python/sh-1.09
"
