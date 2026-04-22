# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Access your OS root certificates with utmost ease"
HOMEPAGE="
	https://github.com/jawah/wassima
	https://pypi.org/project/wassima/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
