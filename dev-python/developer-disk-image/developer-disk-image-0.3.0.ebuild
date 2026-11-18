# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/doronz88/DeveloperDiskImage
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Download DeveloperDiskImage and personalized images from GitHub"
HOMEPAGE="https://github.com/doronz88/DeveloperDiskImage https://pypi.org/project/developer-disk-image/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"

# The tests download images from GitHub.
