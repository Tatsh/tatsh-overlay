# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

MY_PN="flac-tools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A set of commands and various library functions to manage FLAC files."
HOMEPAGE="http://pypi.python.org/pypi/flac-tools/"
SRC_URI="https://pypi.python.org/packages/source/f/flac-tools/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/sh-1.0.9
	>=dev-python/six-1.6.1
	>=media-libs/flac-1.3.0
	>=media-sound/lame-3.99.3
	>=media-sound/sox-14.4.1"

src_install() {
	distutils-r1_src_install

	# These do not work yet
	for suffix in album artist genre title track year; do
		dosym /usr/bin/flacted "/usr/bin/flac-${suffix}"
	done
}

# kate: replace-tabs false
