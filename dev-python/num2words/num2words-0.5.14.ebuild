# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Modules to convert numbers to words, easily extensible."
HOMEPAGE="https://github.com/savoirfairelinux/num2words"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/docopt-0.6.2[${PYTHON_USEDEP}]"
