# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
inherit distutils-r1

DESCRIPTION="Mechanism to restore metadata from certain releasesd files."
HOMEPAGE="http://rescene.wikidot.com/ https://bitbucket.org/Gfy/pyrescene/downloads/"
MY_PN="pyReScene"
SRC_URI="https://bitbucket.org/Gfy/${PN}/downloads/${MY_PN}-${PV}.zip -> ${P}.zip"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

BDEPEND="app-arch/unzip"
