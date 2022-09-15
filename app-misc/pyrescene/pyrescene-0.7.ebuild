# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=no
inherit distutils-r1

DESCRIPTION="Mechanism to restore metadata from certain releasesd files."
HOMEPAGE="http://rescene.wikidot.com/ https://bitbucket.org/Gfy/pyrescene/downloads/"
MY_PN="pyReScene"
SRC_URI="https://bitbucket.org/Gfy/${PN}/downloads/${MY_PN}-${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

S="${WORKDIR}/${MY_PN}-${PV}"
