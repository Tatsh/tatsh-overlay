# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Formatron empowers everyone to control the output format of language models with minimal overhead."
HOMEPAGE="https://pypi.org/project/formatron/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/frozendict-3[${PYTHON_USEDEP}]
	>=dev-python/frozendict-2[${PYTHON_USEDEP}]
	<dev-python/general-sam-2[${PYTHON_USEDEP}]
	>=dev-python/general-sam-1[${PYTHON_USEDEP}]
	<dev-python/jsonschema-5[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4[${PYTHON_USEDEP}]
	<dev-python/kbnf-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/kbnf-0.4.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2[${PYTHON_USEDEP}]"

src_prepare() {
	sed -re 's/typing\.Type/Type/g' \
		-e 's/typing\.Any/Any/g' \
		-i src/formatron/schemas/dict_inference.py || die
	sed -re 's/^from pydantic import typing$/import typing/' \
		-i src/formatron/schemas/json_schema.py || die
	distutils-r1_src_prepare
}
