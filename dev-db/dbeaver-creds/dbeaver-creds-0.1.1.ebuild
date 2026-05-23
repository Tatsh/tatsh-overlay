# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{11..14} )

PYPI_PN=dbeaver_creds

inherit cmake distutils-r1 pypi

DESCRIPTION="Recover your DBeaver saved credentials."
HOMEPAGE="
	https://tatsh.github.io/dbeaver-creds/
	https://github.com/Tatsh/dbeaver-creds
	https://pypi.org/project/dbeaver-creds/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/openssl-3.0
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-python/scikit-build-core-0.12.2[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
