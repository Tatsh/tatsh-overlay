# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
inherit distutils-r1

DESCRIPTION="Asynchronous Python HTTP for Humans."
HOMEPAGE="https://github.com/ross/requests-futures"
SRC_URI="https://files.pythonhosted.org/packages/47/c4/fd48d1ac5110a5457c71ac7cc4caa93da10a80b8de71112430e439bdee22/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/requests"
RDEPEND="${DEPEND}"
BDEPEND=""
