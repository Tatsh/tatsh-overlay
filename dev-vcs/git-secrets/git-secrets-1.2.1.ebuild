# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Prevents you from committing passwords and other sensitive information to a git repository."
HOMEPAGE="https://github.com/awslabs/git-secrets"
SRC_URI="https://github.com/awslabs/git-secrets/archive/1.2.1.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-vcs/git-2.10.2"
DEPEND="${RDEPEND}"

src_compile () {
	einfo 'Nothing to compile'
}

src_install () {
	default
	dodoc *.txt *.md
}
