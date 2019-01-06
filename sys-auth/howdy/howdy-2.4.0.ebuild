# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{4..6} )
inherit python-r1

DESCRIPTION="Windows Hello™ style authentication for Linux"
HOMEPAGE="https://github.com/boltgolt/howdy"
SRC_URI="https://github.com/boltgolt/howdy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	media-libs/opencv:0/3.4.1[cuda]
	sci-libs/hdf5
	dev-python/numpy[$(python_gen_usedep 'python3*')]
	dev-python/pillow[$(python_gen_usedep 'python3*')]
	dev-python/click[$(python_gen_usedep 'python3*')]
	dev-python/face_recognition[$(python_gen_usedep 'python3*')]
	sci-libs/dlib[cuda,python]
	dev-python/pam-python"
DEPEND="${RDEPEND}"
BDEPEND=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CONFIG_PROTECT="/lib/security/howdy/config.ini"

DOCS=( LICENSE README.md debian/changelog )

src_compile() {
	:
}

src_install() {
	einstalldocs
	insinto /lib/security/howdy
	doins -r src/*
	insinto /usr/share/bash-completion/completions
	doins autocomplete/howdy
	doman debian/howdy.1
	exeinto /lib/security/howdy
	doexe src/cli.py
	dosym /lib/security/howdy/cli.py /usr/bin/howdy
	keepdir /lib/security/howdy/models
}
