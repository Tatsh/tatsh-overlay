# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Validating URI References per RFC 3986."
HOMEPAGE="https://github.com/python-hyper/rfc3986"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
