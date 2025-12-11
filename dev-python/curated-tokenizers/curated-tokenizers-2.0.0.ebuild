# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Lightweight piece tokenization library."
HOMEPAGE="https://github.com/explosion/curated-tokenizers"
SRC_URI="https://github.com/explosion/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

PATCHES=(
	"${FILESDIR}/${P}-system-deps.patch"
	"${FILESDIR}/${PN}-system-headers.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/regex-2022[${PYTHON_USEDEP}]
	dev-cpp/abseil-cpp
	dev-libs/protobuf
	sci-ml/sentencepiece"
