# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Save Instagram content you have access to."
HOMEPAGE="
	https://tatsh.github.io/instagram-archiver/
	https://github.com/Tatsh/instagram-archiver
	https://pypi.org/project/instagram-archiver/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/archiver-stats[${PYTHON_USEDEP}]
	dev-python/bascom[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/niquests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/yt-dlp-utils[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
