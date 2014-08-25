# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{2,3} )

inherit distutils-r1

MY_P="${PN}-${PV}"

DESCRIPTION="Extension for os module, for POSIX systems only"
HOMEPAGE="http://pypi.python.org/pypi/sync-github-forks/"
SRC_URI="https://pypi.python.org/packages/source/s/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/osextension-0.1.2
	>=dev-python/PyGithub-1.25.0
	>=dev-python/pyyaml-3.10
	>=dev-python/sh-1.09
"
