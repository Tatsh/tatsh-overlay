# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Bencode encoder/decoder written Python 3."
HOMEPAGE="https://github.com/eweast/bencodepy"
SRC_URI="https://files.pythonhosted.org/packages/d8/72/e2ee9f8a93c92af1ba2d7ef903fd653ef397564ef7715c6ab3eb462f6e29/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
