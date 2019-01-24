# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Safely store secrets in Git/Mercurial/Subversion"
HOMEPAGE="https://github.com/StackExchange/blackbox"
SRC_URI="https://github.com/StackExchange/blackbox/archive/v1.20181219.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( AUTHORS CHANGELOG.md LICENSE.txt README.md Version2-Ideas.md )

src_compile() {
	:
}

src_install() {
	rm bin/Makefile
	dobin bin/*
	einstalldocs
}
