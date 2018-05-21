# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bash-completion-r1 git-2

DESCRIPTION="A fork of the git-flow bash completions to provide completions for DataSift's hubflow fork of git-flow."
HOMEPAGE="https://github.com/ladyrassilon/git-hubflow-completion"
EGIT_REPO_URI="https://github.com/ladyrassilon/git-hubflow-completion.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-vcs/git
"

src_install() {
	newbashcomp git-hubflow-completion.bash hubflow
}
