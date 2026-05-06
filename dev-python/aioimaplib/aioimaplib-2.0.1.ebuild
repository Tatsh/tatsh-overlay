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

BDEPEND="test? (
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/httpx-oauth[${PYTHON_USEDEP}]
	dev-python/imaplib2[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
