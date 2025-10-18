# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Segmentation with orthography profiles."
HOMEPAGE="https://github.com/cldf/segments"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/csvw-1.5.6[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]"
