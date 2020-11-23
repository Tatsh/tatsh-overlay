# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Recover your DBeaver saved credentials."
HOMEPAGE="https://github.com/Tatsh/dbeaver-creds"
MY_SHA="dc2306fe715d1c925b3da747b2153e56e4b65257"
SRC_URI="https://github.com/Tatsh/dbeaver-creds/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND} dev-libs/openssl"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

src_install() {
	dobin "${PN}"
}
