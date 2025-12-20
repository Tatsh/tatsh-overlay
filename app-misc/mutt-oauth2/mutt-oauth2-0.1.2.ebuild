# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="Packaged, maintained version of contributed mutt_oauth2.py script."
HOMEPAGE="https://github.com/Tatsh/mutt-oauth2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

RDEPEND="dev-python/bascom[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
