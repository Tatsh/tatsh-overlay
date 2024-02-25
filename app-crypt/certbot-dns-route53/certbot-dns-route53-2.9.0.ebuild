# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Route53 DNS Authenticator plugin for Certbot"
HOMEPAGE="https://pypi.org/project/certbot-dns-route53/
	https://github.com/certbot/certbot/tree/master/certbot-dns-route53"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-crypt/certbot[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
