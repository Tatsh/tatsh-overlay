# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Utilities for programmatic use of yt-dlp."
HOMEPAGE="https://pypi.org/project/yt-dlp-utils/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-misc/yt-dlp[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
