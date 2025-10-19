# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Vietnamese NLP Toolkit."
HOMEPAGE="https://pypi.org/project/underthesea/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
