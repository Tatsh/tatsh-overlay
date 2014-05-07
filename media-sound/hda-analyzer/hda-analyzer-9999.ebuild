# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit distutils-r1 git-2 python-utils-r1

DESCRIPTION="Provides a graphical interface to access raw Intel HD audio control"
HOMEPAGE="http://www.alsa-project.org/main/index.php/HDA_Analyzer"
EGIT_REPO_URI="git://git.alsa-project.org/alsa.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-python/pygobject-2.28.6-r55"
DEPEND="${RDEPEND}"

src_compile() {
	python_export_best
	python_optimize hda-analyzer
}

src_install() {
	insinto /usr/$(get_libdir)/hda-analyzer
	doins hda-analyzer/*.py*

	exeinto /usr/bin
	doexe "${FILESDIR}/hda-analyzer"
}
