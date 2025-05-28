# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1 pypi

DESCRIPTION="Tool to download data from Patreon."
HOMEPAGE="https://pypi.org/project/patreon-archiver/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/yt-dlp-utils[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
        distutils-r1_src_install
        doman "man/${PN}.1"
}

distutils_enable_tests pytest
