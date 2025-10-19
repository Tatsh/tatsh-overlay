# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=flit

inherit distutils-r1 pypi

DESCRIPTION="Pathlib-style classes for cloud storage services."
HOMEPAGE="https://github.com/drivendataorg/cloudpathlib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
