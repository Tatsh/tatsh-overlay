# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_PEP517=poetry
PYPI_PN="portage-${PN}"
inherit distutils-r1 pypi

DESCRIPTION="Tool to update ebuilds."
HOMEPAGE="https://pypi.org/project/portage-livecheck/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
