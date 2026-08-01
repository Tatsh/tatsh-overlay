# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

declare -A GIT_CRATES=(
	[barrel]='https://github.com/prisma/barrel;4e84cf3d5013b4c92eb81d7ba90cd1c1c01c6805;barrel-%commit%'
	[cuid-util]='https://github.com/prisma/cuid-rust;dc68c4f47a3dbcd511f605135ac7c948775a3ab9;cuid-rust-%commit%/crates/cuid-util'
	[cuid1]='https://github.com/prisma/cuid-rust;dc68c4f47a3dbcd511f605135ac7c948775a3ab9;cuid-rust-%commit%/crates/cuid1'
	[cuid2]='https://github.com/prisma/cuid-rust;dc68c4f47a3dbcd511f605135ac7c948775a3ab9;cuid-rust-%commit%/crates/cuid2'
	[cuid]='https://github.com/prisma/cuid-rust;dc68c4f47a3dbcd511f605135ac7c948775a3ab9;cuid-rust-%commit%/crates/cuid'
	[graphql-parser]='https://github.com/prisma/graphql-parser;6a3f58bd879065588e710cb02b5bd30c1ce182c3;graphql-parser-%commit%'
	[mysql_async]='https://github.com/prisma/mysql_async;c4c841c9d03e361df7377264a075335a823534ee;mysql_async-%commit%'
	[postgres-native-tls]='https://github.com/prisma/rust-postgres;278641fa1a08b7e7d35841342ab4426c5b063d9a;rust-postgres-%commit%/postgres-native-tls'
	[postgres-protocol]='https://github.com/prisma/rust-postgres;278641fa1a08b7e7d35841342ab4426c5b063d9a;rust-postgres-%commit%/postgres-protocol'
	[postgres-types]='https://github.com/prisma/rust-postgres;278641fa1a08b7e7d35841342ab4426c5b063d9a;rust-postgres-%commit%/postgres-types'
	[tiberius]='https://github.com/prisma/tiberius;59db57960a14b422fb3a1309aa4aa47880896ff8;tiberius-%commit%'
	[tokio-postgres]='https://github.com/prisma/rust-postgres;278641fa1a08b7e7d35841342ab4426c5b063d9a;rust-postgres-%commit%/tokio-postgres'
)
RUST_MIN_VER="1.92.0"

inherit cargo

DESCRIPTION="Prisma's database engines."
HOMEPAGE="https://github.com/prisma/prisma-engines"
SRC_URI="https://github.com/prisma/prisma-engines/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0 Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl:=
	virtual/zlib"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-getrandom.patch"
)

QA_FLAGS_IGNORED="usr/bin/.*"

src_prepare() {
	default
	export GIT_HASH="${PV}"
	find . -name build.rs -exec sed -re '/.*build_utils::store_git.*;$/d' -i {} ';'
}

src_install() {
	dobin target/release/{prisma-fmt,query-compiler-playground,schema-engine}
}
