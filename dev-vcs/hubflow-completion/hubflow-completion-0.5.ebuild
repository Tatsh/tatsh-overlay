# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="A fork of the git-flow bash completions to provide completions for DataSift's hubflow fork of git-flow."
HOMEPAGE="https://github.com/ladyrassilon/git-hubflow-completion"
SRC_URI="https://github.com/ladyrassilon/git-hubflow-completion/archive/0.5.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/git-$P"

src_install() {
	sed -e 's/\(\s\+\)local subcommands="\([^"]\+\)"/\1local subcommands="\2 push"/' -i git-hubflow-completion.bash
	insinto /etc/bash_completion.d
	cp git-hubflow-completion.bash "$PN"
	doins "$PN"
	dodoc README.markdown LICENSE
}
