# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9,10} )
inherit distutils-r1

DESCRIPTION="Simple ASN.1 encoder/decoder."
HOMEPAGE="https://pypi.org/project/asn1/"
SRC_URI="https://github.com/andrivet/python-asn1/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
