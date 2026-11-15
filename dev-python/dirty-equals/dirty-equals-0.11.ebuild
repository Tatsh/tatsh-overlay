# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Doing dirty (but extremely useful) things with equals"
HOMEPAGE="
	https://github.com/samuelcolvin/dirty-equals
	https://dirty-equals.helpmanual.io/latest/
	https://pypi.org/project/dirty-equals/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/packaging[${PYTHON_USEDEP}]
		>=dev-python/pytest-examples-0.0.18-r1[${PYTHON_USEDEP}]
	)
"

src_test() {
	# The unix timestamp tests compare against naive datetimes in UTC.
	local -x TZ=UTC
	distutils-r1_src_test
}

EPYTEST_PLUGINS=( pytest-examples pytest-pretty )
distutils_enable_tests pytest
