# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Wizard-like JSON serialization library for Python dataclasses"
HOMEPAGE="https://github.com/rnag/dataclass-wizard https://pypi.org/project/dataclass-wizard/"
# The sdist leaves out test support files and data.
SRC_URI="https://github.com/rnag/dataclass-wizard/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.13.0[${PYTHON_USEDEP}]
	' python3_12)
"
BDEPEND="
	test? (
		dev-python/python-dotenv[${PYTHON_USEDEP}]
		dev-python/pytimeparse[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		dev-python/tzdata[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest
