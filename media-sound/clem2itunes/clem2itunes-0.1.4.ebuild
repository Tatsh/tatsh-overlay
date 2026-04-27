# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Sync a remote Strawberry rated library to Music.app using Python, JXA and SSH."
HOMEPAGE="
	https://github.com/Tatsh/clem2itunes
	https://pypi.org/project/clem2itunes/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/aiosqlite-0.22.1[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/click-aliases-1.0.5[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	media-sound/id3ted
	media-sound/mp3check
	media-sound/mp3splt
	media-video/atomicparsley"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

src_prepare() {
	rm "${PN}/index.js" || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
