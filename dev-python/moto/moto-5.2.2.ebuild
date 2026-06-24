# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="A library that allows you to easily mock out tests based on AWS infrastructure"
HOMEPAGE="
	https://github.com/getmoto/moto
	https://pypi.org/project/moto/
	http://docs.getmoto.org/en/latest/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/boto3-1.9.201[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.20.88[${PYTHON_USEDEP}]
	!~dev-python/botocore-1.35.45[${PYTHON_USEDEP}]
	!~dev-python/botocore-1.35.46[${PYTHON_USEDEP}]
	>=dev-python/cryptography-35.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.5[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.5[${PYTHON_USEDEP}]
	!~dev-python/werkzeug-2.2.0[${PYTHON_USEDEP}]
	!~dev-python/werkzeug-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/responses-0.15.0[${PYTHON_USEDEP}]
	!~dev-python/responses-0.25.5[${PYTHON_USEDEP}]"
