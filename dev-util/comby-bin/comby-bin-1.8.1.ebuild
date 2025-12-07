# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Code rewrite tool for structural search and replace."
HOMEPAGE="https://comby.dev/"
SRC_URI="https://github.com/comby-tools/comby/releases/download/${PV}/comby-${PV}-x86_64-linux.tar.gz"
S="${WORKDIR}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-db/sqlite
	dev-libs/libpcre-debian
	dev-libs/gmp
	dev-libs/libev
	dev-libs/libpcre2
	virtual/zlib"

src_install() {
	exeinto /usr/lib64
	newexe "comby-${PV}-x86_64-linux" comby
	make_wrapper comby "${EPREFIX}/usr/lib64/comby" . "${EPREFIX}/usr/lib64/debiancompat"
}
