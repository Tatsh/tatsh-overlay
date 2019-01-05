# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )
inherit python-r1

DESCRIPTION="Windows Hello™ style authentication for Linux"
HOMEPAGE="https://github.com/boltgolt/howdy"
SRC_URI="https://github.com/boltgolt/howdy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/opencv:0/3.4.1[cuda,$(python_gen_usedep 'python3*')]
	sci-libs/hdf5
	dev-python/pillow[$(python_gen_usedep 'python3*')]
	dev-python/click[$(python_gen_usedep 'python3*')]
	dev-python/face_recognition_models[$(python_gen_usedep 'python3*')]
	sci-libs/dlib[$(python_gen_usedep 'python3*')]
	dev-python/numpy[$(python_gen_usedep 'python3*')]"
DEPEND="${RDEPEND}"
BDEPEND=""

DOCS=( LICENSE README.md )

src_compile() {
	einfo
}

src_install() {
	chmod -R 0600 src
	chmod 0700 src/cli.py
	insinto /lib/security/howdy
	doins -r src/*
	dosym /lib/security/howdy/cli.py /usr/bin/howdy
	insinto /usr/share/bash-completion/completions
	doins autocomplete/howdy
}
