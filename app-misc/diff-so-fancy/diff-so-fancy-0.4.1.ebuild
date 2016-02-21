# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Good-lookin' diffs with diff-highlight and more"
HOMEPAGE="https://github.com/so-fancy/diff-so-fancy"
SRC_URI="https://github.com/so-fancy/diff-so-fancy/archive/v0.4.1.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '22s:diff-highlight:diff-highlight-so-fancy:' \
		-e '23s:diff-highlight:diff-highlight-so-fancy:' \
		-i diff-so-fancy
}

src_install() {
	exeinto /usr/bin
	doexe diff-so-fancy
	cp third_party/diff-highlight/diff-highlight diff-highlight-so-fancy
	doexe diff-highlight-so-fancy

	dodoc readme.md
}

pkg_postinst() {
	einfo
	einfo 'To use this package automatically with git, issue the following commands:'
	einfo
	einfo 'git config --global pager.diff "diff-so-fancy | less --tabs=1,5 -RFX"'
	einfo 'git config --global pager.show "diff-so-fancy | less --tabs=1,5 -RFX"'
	einfo
	einfo 'You can also use this command separately with a command in ~/.gitconfig:'
	einfo
	einfo 'dsf = "!git diff --color $@ | diff-so-fancy"'
	einfo
}
