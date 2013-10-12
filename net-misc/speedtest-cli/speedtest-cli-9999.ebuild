# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python{2_5,2_6,2_7,3_1,3_2,3_3})
DISTUTILS_SINGLE_IMPL=true
inherit git-2 eutils distutils-r1

DESCRIPTION="Command line interface for testing internet bandwidth using speedtest.net"
HOMEPAGE="https://github.com/sivel/speedtest-cli"
EGIT_REPO_URI="https://github.com/sivel/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	python_domodule speedtest_cli.py
	dobin speedtest_cli.py
	dosym speedtest_cli.py /usr/bin/speedtest
	dodoc LICENSE README.rst
	python_fix_shebang "${ED}"
}
