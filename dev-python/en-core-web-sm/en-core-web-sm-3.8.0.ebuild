# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0..4} )

inherit distutils-r1

DESCRIPTION="English pipeline optimized for CPU."
HOMEPAGE="https://spacy.io/models/en#en_core_web_sm https://github.com/explosion/spacy-models"
SRC_URI="https://github.com/explosion/spacy-models/releases/download/${PN//-/_}-${PV}/${PN//-/_}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN//-/_}-${PV}"

distutils_enable_tests pytest
