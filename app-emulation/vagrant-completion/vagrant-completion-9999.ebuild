# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 bash-completion-r1

DESCRIPTION="Bash auto-completion for Vagrant"
HOMEPAGE="https://github.com/kura/vagrant-bash-completion"
EGIT_REPO_URI="git://github.com/Tatsh/vagrant-bash-completion.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	einfo 'Nothing to compile!'
}

src_install() {
	newbashcomp etc/bash_completion.d/vagrant vagrant
}

# kate: replace-tabs false;
