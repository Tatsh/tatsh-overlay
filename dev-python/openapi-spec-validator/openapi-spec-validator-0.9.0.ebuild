# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="OpenAPI 2.0 (aka Swagger) and OpenAPI 3 spec validator"
HOMEPAGE="
	https://github.com/python-openapi/openapi-spec-validator
	https://pypi.org/project/openapi-spec-validator/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/jsonschema-4.24.0[${PYTHON_USEDEP}]
	<dev-python/jsonschema-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-path-0.4.3[${PYTHON_USEDEP}]
	<dev-python/jsonschema-path-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/lazy-object-proxy-1.7.1[${PYTHON_USEDEP}]
	<dev-python/lazy-object-proxy-2.0[${PYTHON_USEDEP}]
	>=dev-python/openapi-schema-validator-0.7.3[${PYTHON_USEDEP}]
	<dev-python/openapi-schema-validator-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.0.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-settings-3.0.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
