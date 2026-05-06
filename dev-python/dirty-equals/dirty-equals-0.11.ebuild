# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Doing dirty (but extremely useful) things with equals"
HOMEPAGE="
	https://github.com/samuelcolvin/dirty-equals
	https://dirty-equals.helpmanual.io/
	https://pypi.org/project/dirty-equals/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# Tests need pytest-examples and pytest-pretty which are not yet packaged.
RESTRICT="test"
