# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Recover your DBeaver saved credentials."
HOMEPAGE="https://github.com/Tatsh/dbeaver-creds"
SHA="13fe2175484e523f47c3c8ee39f07d449ff76932"
SRC_URI="https://github.com/Tatsh/dbeaver-creds/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-libs/openssl"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	dobin "${PN}"
}
