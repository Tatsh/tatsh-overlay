# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Utils for streaming large files (S3, HDFS, GCS, Azure, gzip, bz2, zst)."
HOMEPAGE="https://github.com/piskvorky/smart_open"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/wrapt[${PYTHON_USEDEP}]"
