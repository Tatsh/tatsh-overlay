# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Fully automatic time tracking for programmers"
HOMEPAGE="https://github.com/wakatime/wakatime"
SRC_URI="https://pypi.python.org/packages/source/w/wakatime/${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
