# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python support for Parquet file format"
HOMEPAGE="https://github.com/dask/fastparquet/"
SRC_URI="https://github.com/dask/fastparquet/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/cramjam-2.3[${PYTHON_USEDEP}]
	dev-python/fsspec[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.5.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

EPYTEST_DESELECT=(
	# pandas 3 behaviour changes (default string dtype, NaN vs None, index names).
	test/test_api.py::test_file_renaming_no_partition
	test/test_api.py::test_file_renaming_with_partitions
	test/test_api.py::test_remove_rgs_no_partition
	test/test_api.py::test_remove_rgs_simple_merge
	test/test_api.py::test_write_rgs_hive
	test/test_api.py::test_write_rgs_hive_partitions
	test/test_api.py::test_write_rgs_simple_no_index
	test/test_dataframe.py::test_pandas_hive_serialization
	test/test_output.py::test_append_fail_incompatible
	test/test_output.py::test_auto_null_object
	test/test_output.py::test_empty_columns
)

src_test() {
	# Import the built extensions rather than the source-tree package, which holds the tests.
	mv "${PN}/test" test || die
	rm -r "${PN}" || die
	# test_write_rgs_simple fails for the same reason, but --deselect matches by
	# prefix and would also drop the passing
	# test_write_rgs_simple_schema_exception.
	local -x PYTEST_ADDOPTS="-k 'not test_write_rgs_simple or schema_exception'"
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
