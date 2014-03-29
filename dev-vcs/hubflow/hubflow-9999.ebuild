# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="A Git extension to make it easy to use GitFlow with GitHub."
HOMEPAGE="https://github.com/datasift/gitflow"
EGIT_REPO_URI="git://github.com/datasift/gitflow.git"
EGIT_HAS_SUBMODULES="x"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-vcs/git-flow-0.4.1
"

src_install() {
	eval "export $(egrep ^EXEC_FILES= install.sh | head -n 1)"
	eval "export $(egrep ^SCRIPT_FILES= install.sh | head -n 1)"

	exeinto /usr/bin
	for i in $EXEC_FILES; do
		doexe "$i"
	done
	for i in $SCRIPT_FILES; do
		[[ "$i" = 'git-hf-update' ]] && continue
		doexe "$i"
	done
}
