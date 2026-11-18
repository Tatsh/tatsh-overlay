# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/doronz88/pytun-pmd3
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="python-pytun fork with Darwin and Windows support"
HOMEPAGE="https://github.com/doronz88/pytun-pmd3 https://pypi.org/project/pytun-pmd3/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	# Windows-only prebuilt wintun.dll and its loader.
	rm -r pytun_pmd3/wintun pytun_pmd3/wintun.py || die
	distutils-r1_src_prepare
}
