# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=true

inherit distutils-r1

DESCRIPTION="Audio fingerprinting and recognition in Python."
HOMEPAGE="https://github.com/worldveil/dejavu"
MY_PN="PyDejavu"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz
	https://raw.githubusercontent.com/worldveil/dejavu/master/dejavu.py
	https://github.com/worldveil/dejavu/blob/master/dejavu.cnf.SAMPLE"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/pyaudio-0.2.7[${PYTHON_USEDEP}]
	>=dev-python/pydub-0.9.4[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.8.2[${PYTHON_USEDEP}]
	>=sci-libs/scipy-0.12.1[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-1.3.1[${PYTHON_USEDEP}]
	dev-python/mysql-python[${PYTHON_USEDEP}]"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	cp "${DISTDIR}/dejavu.py" .
	sed -e '16s:dejavu.cnf.SAMPLE:/etc/dejavu.cnf:' -i dejavu.py
	default
}

src_install() {
	distutils-r1_python_install
	dobin dejavu.py
	mkdir -p "${D}/etc"
	cp "${DISTDIR}/dejavu.cnf.SAMPLE" "${D}/etc/dejavu.cnf"
}
