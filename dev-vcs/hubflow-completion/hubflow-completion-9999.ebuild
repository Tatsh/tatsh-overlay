# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
inherit git-r3

DESCRIPTION="A fork of the git-flow bash completions to provide completions for DataSift's hubflow fork of git-flow."
HOMEPAGE="https://github.com/ladyrassilon/git-hubflow-completion"
EGIT_REPO_URI="https://github.com/ladyrassilon/git-hubflow-completion.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc/bash_completion.d
	cp git-hubflow-completion.bash "$PN"
	doins "$PN"
}
