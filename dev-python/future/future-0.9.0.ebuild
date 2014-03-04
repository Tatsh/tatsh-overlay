# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
# TODO Support Python 2.6? If so, IUSE must have conditional: unittest2, argparse, importlib
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Easy, safe, clean Python 2/3 compatibility"
HOMEPAGE="http://python-future.org/"
SRC_URI="https://pypi.python.org/packages/source/f/future/future-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
