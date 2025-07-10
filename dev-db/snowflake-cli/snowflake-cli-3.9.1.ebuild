# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1 pypi

DESCRIPTION="CLI to Snowflake database."
HOMEPAGE="https://pypi.org/project/snowflake-cli-labs/"
SRC_URI="https://github.com/snowflakedb/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requirements-parser[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/snowflake-core[${PYTHON_USEDEP}]
	dev-python/snowflake-connector-python[secure-local-storage,${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/typer[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.9.2[${PYTHON_USEDEP}]
	dev-python/gitpython[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	sed -re '/^license =/d' -i pyproject.toml || die
	distutils-r1_src_prepare
}

python_install() {
	rm README.md || die
	distutils-r1_python_install
}

distutils_enable_tests pytest
