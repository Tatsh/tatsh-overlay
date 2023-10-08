# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Completely rewritten adbsync with proper --exclude."
HOMEPAGE="https://github.com/jb2170/better-adb-sync"
MY_PN=BetterADBSync
SRC_URI="$(pypi_sdist_url --no-normalize "${MY_PN}")"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
BDEPEND="${RDEPEND}"

S="${WORKDIR}/BetterADBSync-${PV}"
