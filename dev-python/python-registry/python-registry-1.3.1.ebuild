# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )
# The sdist predates PEP 625, so it still uses the hyphenated filename.
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Read access to Windows Registry hive files."
HOMEPAGE="https://github.com/williballenthin/python-registry
	https://pypi.org/project/python-registry/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# Upstream still declares enum-compat and unicodecsv, both Python 2 shims.
# enum is in the standard library and unicodecsv is never imported.
