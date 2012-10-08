# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="A Python interface to the libmagic file type identification library"
HOMEPAGE="https://github.com/ahupp/python-magic"
SRC_URI="http://files.tatsh.net/${P}.tar.gz"

LICENSE="PSF"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

S="${WORKDIR}/ahupp-python-magic-4d98bc0"
