# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="The fast, Pythonic way to build MCP servers and clients."
HOMEPAGE="https://github.com/PrefectHQ/fastmcp"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/authlib-1.6.11[${PYTHON_USEDEP}]
	>=dev-python/cyclopts-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/griffelib-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	<dev-python/httpx-1.0[${PYTHON_USEDEP}]
	>=dev-python/joserfc-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonref-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-path-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.24.0[${PYTHON_USEDEP}]
	<dev-python/mcp-2.0[${PYTHON_USEDEP}]
	>=dev-python/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/py-key-value-aio-0.4.4[${PYTHON_USEDEP}]
	<dev-python/py-key-value-aio-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.7[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.26[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	<dev-python/pyyaml-7.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/starlette-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/uncalled-for-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.35[${PYTHON_USEDEP}]
	>=dev-python/watchfiles-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/dirty-equals[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	dev-python/inline-snapshot[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/opentelemetry-exporter-otlp-proto-grpc[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/pdbpp[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyinstrument[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/pytest-env[${PYTHON_USEDEP}]
	dev-python/pytest-examples[${PYTHON_USEDEP}]
	dev-python/pytest-flakefinder[${PYTHON_USEDEP}]
	dev-python/pytest-httpx[${PYTHON_USEDEP}]
	dev-python/pytest-report[${PYTHON_USEDEP}]
	dev-python/pytest-retry[${PYTHON_USEDEP}]
	dev-python/pytest-timeout[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
)"

src_prepare() {
	# As of 3.x the top-level fastmcp distribution is an empty meta-package that
	# merely depends on fastmcp-slim; the actual module lives in fastmcp_slim/.
	# Build that project from the sdist root so tests/ stays in reach, treating
	# fastmcp_slim/ as a src-layout directory.
	cp fastmcp_slim/pyproject.toml pyproject.toml || die
	# uv-dynamic-versioning is not packaged. It only supplies the version and
	# the extras, and both are expressed statically here and in RDEPEND.
	sed -i \
		-e 's/^dynamic = .*/version = "'"${PV}"'"/' \
		-e 's/, "uv-dynamic-versioning>=0.7.0"//' \
		-e 's|^packages = \["fastmcp"\]|packages = ["fastmcp_slim/fastmcp"]|' \
		-e '/^\[tool\.hatch\.version\]/,/^$/d' \
		-e '/^\[tool\.uv-dynamic-versioning\]/,/^$/d' \
		-e '/^\[tool\.hatch\.metadata\.hooks\.uv-dynamic-versioning/,$d' \
		pyproject.toml || die
	distutils-r1_src_prepare
}

EPYTEST_PLUGINS=( pytest-asyncio pytest-cov pytest-env pytest-examples pytest-flakefinder pytest-httpx pytest-report pytest-retry pytest-timeout pytest-xdist )
distutils_enable_tests pytest
