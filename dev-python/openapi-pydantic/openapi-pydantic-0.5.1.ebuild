# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Pydantic OpenAPI schema implementation."
HOMEPAGE="https://github.com/mike-oakley/openapi-pydantic"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pydantic-1.8[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/openapi-spec-validator[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
