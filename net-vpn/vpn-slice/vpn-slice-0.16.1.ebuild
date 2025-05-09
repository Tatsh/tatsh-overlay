# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="vpnc-script replacement for easy and secure split-tunnel VPN setup."
HOMEPAGE="https://github.com/dlenski/vpn-slice https://pypi.org/project/vpn-slice/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}] net-dns/bind-tools"

S="${WORKDIR}/${P}"
