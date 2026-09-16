# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

PYPI_VERIFY_REPO="https://github.com/ashuttl/linecast"

inherit distutils-r1 pypi

DESCRIPTION="Weather, tides, the sun, the moon, and maps, drawn for the terminal."
HOMEPAGE="https://github.com/ashuttl/linecast https://terminaltrove.com/linecast/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# Upstream declares only tzdata and truststore, both behind a
# sys_platform == 'win32' marker. Everything else is the standard library.

python_test() {
	# The suite puts src/ on sys.path from inside the test modules, which a
	# subprocess does not inherit, so
	# test_the_installed_command_prints_no_traceback ("python -m
	# linecast.units") only passes where linecast is really importable. Point
	# PYTHONPATH at the wheel already installed into BUILD_DIR.
	local -x PYTHONPATH
	PYTHONPATH="${BUILD_DIR}/install$(python_get_sitedir)"
	epytest
}

distutils_enable_tests pytest
