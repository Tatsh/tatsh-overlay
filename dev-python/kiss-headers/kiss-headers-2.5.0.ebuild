# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Object-oriented HTTP and IMAP (structured) headers"
HOMEPAGE="
	https://jawah.github.io/kiss-headers
	https://github.com/jawah/kiss-headers
	https://pypi.org/project/kiss-headers/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
