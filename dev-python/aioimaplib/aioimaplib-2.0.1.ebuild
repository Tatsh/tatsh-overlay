# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python asyncio IMAP4rev1 client library"
HOMEPAGE="
	https://github.com/bamthomas/aioimaplib
	https://pypi.org/project/aioimaplib/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
