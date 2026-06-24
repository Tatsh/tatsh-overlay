# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asyncio SMTP client"
HOMEPAGE="
	https://github.com/cole/aiosmtplib
	https://aiosmtplib.readthedocs.io/
	https://pypi.org/project/aiosmtplib/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
