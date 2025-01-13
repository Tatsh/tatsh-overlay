# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

DESCRIPTION="Lame database tool."
HOMEPAGE="https://docs.snowflake.com/en/user-guide/snowsql"
SRC_URI="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.3/linux_x86_64/snowflake-${P}-1.x86_64.rpm"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/libcrypt"
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="strip"

S="${WORKDIR}/usr"

src_install() {
	dobin "bin/${PN}"
	cp -R lib64 "${D}/usr/lib64"
}
