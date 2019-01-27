# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Prevents you from committing passwords and other sensitive information to a git repository."
HOMEPAGE="https://github.com/awslabs/git-secrets"
MY_HASH="c11c229a8eebb3545e5fd3bab4e8aa55a7f19383"
SRC_URI="https://github.com/awslabs/git-secrets/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-vcs/git-2.10.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_HASH}"
DOCS=( CHANGELOG.md CONTRIBUTING.md LICENSE.txt NOTICE.txt README.rst )

src_compile () {
	emake man
}

src_install () {
	default
	doman "${PN}.1"
	einstalldocs
}
