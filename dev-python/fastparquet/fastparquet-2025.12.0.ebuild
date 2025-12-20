# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Python support for Parquet file format."
HOMEPAGE="https://github.com/dask/fastparquet/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/cramjam-2.3[${PYTHON_USEDEP}]
	dev-python/fsspec[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.5.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"
