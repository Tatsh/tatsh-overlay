# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 pam

DESCRIPTION="Enables PAM modules to be written in Python."
HOMEPAGE="https://sourceforge.net/projects/pam-python"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${P}/src"

DOCS=( ../README.txt ../ChangeLog.txt )
HTML_DOCS=( ../pam-python.html )

DISTUTILS_ALL_SUBPHASE_IMPLS=( 'python2*' )

src_prepare() {
	eapply -p2 "${FILESDIR}/${P}-fedora.patch"
	default
}

src_install() {
	dopammod "${WORKDIR}/${P}/src-python2_7/lib/pam_python.so"
	distutils-r1_python_install_all
}
