# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Lightweight piece tokenization library."
HOMEPAGE="https://github.com/explosion/curated-tokenizers"

PATCHES=( "${FILESDIR}/${PN}-fix-comma.patch" )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/regex-2022[${PYTHON_USEDEP}]"
