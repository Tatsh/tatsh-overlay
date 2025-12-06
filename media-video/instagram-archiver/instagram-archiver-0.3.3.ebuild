# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
inherit distutils-r1 pypi

DESCRIPTION="Tool to download data from an Instagram profile you have access to."
HOMEPAGE="https://pypi.org/project/instagram-archiver/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/yt-dlp-utils[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
