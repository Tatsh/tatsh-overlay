# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A Hangul syllable and jamo analyzer."
HOMEPAGE="https://pypi.org/project/jamo/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
