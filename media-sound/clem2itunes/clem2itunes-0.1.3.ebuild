# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Sync a remote Strawberry rated library to Music.app using Python, JXA and SSH."
HOMEPAGE="https://github.com/Tatsh/clem2itunes"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/bascom[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-aliases[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	media-sound/id3ted
	media-sound/mp3check
	media-sound/mp3splt
	media-video/atomicparsley"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
)"

src_prepare() {
	rm "${PN}/index.js" || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
