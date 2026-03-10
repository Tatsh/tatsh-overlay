# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="N64 image format library."
HOMEPAGE="https://pypi.org/project/n64img/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pypng[${PYTHON_USEDEP}]"

python_prepare_all() {
	if ! use test; then
		rm -rf test || die
	fi
	echo 'build-backend = "setuptools.build_meta"' >> pyproject.toml
	distutils-r1_python_prepare_all
}

distutils_enable_tests unittest
