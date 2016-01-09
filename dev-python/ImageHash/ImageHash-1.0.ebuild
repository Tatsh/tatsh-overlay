# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="An image hashing library written in Python"
HOMEPAGE="https://pypi.python.org/pypi/ImageHash https://github.com/JohannesBuchner/imagehash"
SRC_URI="https://pypi.python.org/packages/source/I/ImageHash/ImageHash-1.0.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=sci-libs/scipy-0.15.1
>=dev-python/numpy-1.9.2
>=dev-python/pillow-2.8.1
"
DEPEND="${RDEPEND}"
