# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="A new flavour of deep learning operations."
HOMEPAGE="https://github.com/arogozhnikov/einops"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
