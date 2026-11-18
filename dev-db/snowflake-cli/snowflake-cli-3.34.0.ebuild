# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )
inherit distutils-r1 pypi

DESCRIPTION="CLI to Snowflake database"
HOMEPAGE="https://pypi.org/project/snowflake-cli-labs/"
SRC_URI="https://github.com/snowflakedb/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# keyring stands in for the connector's secure-local-storage extra, which
# 5.x no longer has. Upstream pins protobuf below 6, which would downgrade it
# for everything else; only Streamlit log streaming uses it. Snowpark
# (snowflake-snowpark-python) is not packaged; it is imported only by the
# commands that need it.
# Upstream pins click 8.1 and typer 0.17; with the click >= 8.2 in ::gentoo
# the CLI fails at startup with "There is no active click context". See
# https://github.com/snowflakedb/snowflake-cli/issues/3175.
RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	>=dev-python/certifi-2026.10.19[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/gitpython[${PYTHON_USEDEP}]
	dev-python/id[${PYTHON_USEDEP}]
	dev-python/jaraco-context[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.9.2[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requirements-parser[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/snowflake-connector-python[${PYTHON_USEDEP}]
	dev-python/snowflake-core[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/typer[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.6.3[${PYTHON_USEDEP}]
	<dev-python/websocket-client-2[${PYTHON_USEDEP}]"

src_prepare() {
	sed -re '/^license =/d' -i pyproject.toml || die
	distutils-r1_src_prepare
}

python_install() {
	rm README.md || die
	distutils-r1_python_install
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
