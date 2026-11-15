# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

PYPI_VERIFY_REPO="https://github.com/getmoto/moto"

inherit distutils-r1 pypi

DESCRIPTION="A library that allows you to easily mock out tests based on AWS infrastructure"
HOMEPAGE="
	https://github.com/getmoto/moto
	https://pypi.org/project/moto/
	https://docs.getmoto.org/en/latest/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# Upstream also blocks botocore 1.35.45/1.35.46, werkzeug 2.2.0/2.2.1 and
# responses 0.25.5. None of those have ever been in the tree, so the blockers
# can never match anything.
RDEPEND=">=dev-python/boto3-1.9.201[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.20.88[${PYTHON_USEDEP}]
	>=dev-python/cryptography-35.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.5[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.5[${PYTHON_USEDEP}]
	>=dev-python/responses-0.15.0[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/antlr4-python3-runtime[${PYTHON_USEDEP}]
		dev-python/aws-xray-sdk[${PYTHON_USEDEP}]
		dev-python/cfn-lint[${PYTHON_USEDEP}]
		dev-python/docker[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/joserfc[${PYTHON_USEDEP}]
		dev-python/jsonpath-ng[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/openapi-spec-validator[${PYTHON_USEDEP}]
		dev-python/pyotp[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/sshpubkeys[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Need py-partiql-parser, which is not packaged.
	tests/test_dynamodb/test_dynamodb_import_table.py
	tests/test_dynamodb/test_dynamodb_statements.py
	tests/test_s3/test_s3_select.py
	# Needs pycognito, which is not packaged.
	tests/test_cognitoidp/test_cognitoidp.py
	# Needs graphql-core, which currently cannot be installed alongside this tree.
	tests/test_appsync/test_appsync_schema.py
)

src_test() {
	# Tests marked requires_docker drive the host's Docker daemon.
	local -x TESTS_SKIP_REQUIRES_DOCKER=true
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
EPYTEST_XDIST=1
distutils_enable_tests pytest
