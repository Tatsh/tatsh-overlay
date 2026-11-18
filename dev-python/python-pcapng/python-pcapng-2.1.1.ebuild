# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Library to read and write the pcap-ng format"
HOMEPAGE="https://github.com/rshk/python-pcapng https://pypi.org/project/python-pcapng/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
