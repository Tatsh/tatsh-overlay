# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4..7} )
inherit distutils-r1

DESCRIPTION="Manipulate audio with a simple and easy high level interface."
HOMEPAGE="http://pydub.com"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/ffmpeg
	dev-python/pyaudio[${PYTHON_USEDEP}]
	dev-python/simpleaudio[$(python_gen_usedep 'python3*')]"
DEPEND="${RDEPEND}"
BDEPEND=""
