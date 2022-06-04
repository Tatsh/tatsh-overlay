# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Recover your DBeaver saved credentials."
HOMEPAGE="https://github.com/Tatsh/dbeaver-creds"
SHA="35a83a6a1c12b39bc0790fa363d7c59bf7c19427"
SRC_URI="https://github.com/Tatsh/dbeaver-creds/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-libs/openssl"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	dobin "${PN}"
}
