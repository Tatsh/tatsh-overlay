# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="Legacy registered functions for spaCy backwards compatibility"
HOMEPAGE="https://github.com/explosion/spacy-legacy"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

S="${WORKDIR}/${PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
