# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

DESCRIPTION="Lightweight piece tokenization library"
HOMEPAGE="https://github.com/explosion/curated-tokenizers"
SRC_URI="https://github.com/explosion/${PN}/archive/refs/tags/release-v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-release-v${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-cython-3.3.patch"
	"${FILESDIR}/${PN}-system-deps.patch"
	"${FILESDIR}/${PN}-system-headers.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/abseil-cpp:=
	dev-libs/protobuf:=
	sci-ml/sentencepiece"
RDEPEND="${DEPEND}
	>=dev-python/regex-2022[${PYTHON_USEDEP}]"
BDEPEND=">=dev-python/cython-3.0[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare
	# >=dev-cpp/abseil-cpp-20260107 headers need C++20
	sed -i 's/--std=c++17/--std=c++20/' setup.py || die
}

src_test() {
	# Import the built extensions rather than the source-tree package, which holds the tests.
	mv "${PN//-/_}/tests" tests || die
	rm -r "${PN//-/_}" || die
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
