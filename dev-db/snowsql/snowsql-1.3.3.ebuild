# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

DESCRIPTION="Lame database tool."
HOMEPAGE="https://docs.snowflake.com/en/user-guide/snowsql"
SRC_URI="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/$(ver_cut 1-2)/linux_x86_64/snowflake-${P}-1.x86_64.rpm"
S="${WORKDIR}/usr"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/ncurses-compat
	virtual/libcrypt
	virtual/zlib"
RDEPEND="${DEPEND}"

RESTRICT="strip"

src_install() {
	dobin "bin/${PN}"
	cp -R lib64 "${D}/usr/lib64"
}
