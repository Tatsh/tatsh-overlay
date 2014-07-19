# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
# PYTHON_COMPAT=( python2_7 python3_{2,3} )

inherit git-2
#inherit git-2 python-r1

DESCRIPTION="Transfers purchases from an iOS device to local system"
HOMEPAGE="https://github.com/Tatsh/misc-scripts"
EGIT_REPO_URI="git://github.com/Tatsh/misc-scripts.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-python/osextension-0.1.2
	>=dev-python/sh-1.09"
DEPEND="${DEPEND}"

# TODO Install for each Python implementation
src_install () {
	exeinto /usr/bin
	doexe "${PN}"
}

# kate: replace-tabs false
