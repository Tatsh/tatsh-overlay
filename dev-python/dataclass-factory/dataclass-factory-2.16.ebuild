# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

MY_PN="${PN//-/_}"

DESCRIPTION="Modern way to convert python dataclasses to and from plain types."
HOMEPAGE="https://github.com/reagento/dataclass-factory"
# The 2.16 release on PyPI is a wheel only, so this uses the tag instead.
# Upstream has since renamed the project to adaptix, which is what the
# generated tarball unpacks as.
SRC_URI="https://github.com/reagento/${PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/adaptix-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# test_literal.py and test_typeddict.py parametrise with nose2.
BDEPEND="test? ( dev-python/nose2[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
