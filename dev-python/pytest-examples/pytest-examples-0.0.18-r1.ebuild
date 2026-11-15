# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..15} )

PYPI_VERIFY_REPO="https://github.com/pydantic/pytest-examples"

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for testing examples in docstrings and markdown files"
HOMEPAGE="
	https://github.com/pydantic/pytest-examples
	https://pypi.org/project/pytest-examples/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/black-23[${PYTHON_USEDEP}]
	>=dev-python/pytest-7[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.5.0"

# lint.py imports the ruff wheel's ruff module to locate the binary;
# dev-util/ruff installs only the binary.
PATCHES=( "${FILESDIR}/${PN}-system-ruff.patch" )

EPYTEST_DESELECT=(
	# Expected output of the ruff, black and pytest versions upstream pins (newer
	# ruff enables FA100; pytest 9 adds deprecation warnings to the output).
	tests/test_lint.py::test_ruff_config
	tests/test_lint.py::test_ruff_offset
	tests/test_run_examples.py::test_black_error
	tests/test_run_examples.py::test_ruff_error
	tests/test_run_examples.py::test_ruff_ok
	tests/test_run_examples.py::test_run_example_ok_fail
)

src_test() {
	# The plugin is enabled with -p, which pytester's nested sessions do not inherit.
	local -x PYTEST_PLUGINS=pytest_examples
	distutils-r1_src_test
}

EPYTEST_PLUGINS=( "${PN}" )
distutils_enable_tests pytest
