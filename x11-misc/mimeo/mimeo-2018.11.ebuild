# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Open files by MIME-type or file name using regular expressions."
HOMEPAGE="http://xyne.archlinux.ca/projects/mimeo/index.html"
SRC_URI="http://xyne.archlinux.ca/projects/${PN}/src/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pyxdg-0.25-r1"
DEPEND="${RDEPEND}"

DOCS=( COPYING CHANGELOG )

python_install_all() {
	distutils-r1_python_install_all
	exeinto /usr/bin
	doexe "${FILESDIR}/mimeo"
	newbashcomp "${FILESDIR}/mimeo-completion.sh" mimeo
}
