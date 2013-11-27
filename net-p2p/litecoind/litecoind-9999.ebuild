# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DB_VER="4.8"

inherit db-use versionator git-2

DESCRIPTION="Litecoin manages to maintain the unique traits and attributes of Bitcoin, while adding to the mixture CPU-specific mining and a 2.5 minute block rate."
HOMEPAGE="http://litecoin.org/"
EGIT_REPO_URI='https://github.com/litecoin-project/litecoin.git'
EGIT_MASTER='master-0.8'

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="ipv6 upnp"

DEPEND="
	>=dev-libs/boost-1.41.0
	dev-libs/openssl[-bindist]
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/001-boost_chrono.patch" || die "Patching failed!"
}

src_compile() {
	OPTS=()

	OPTS+=("DEBUGFLAGS=")
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS}")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	if use upnp; then
		OPTS+=(USE_UPNP=1)
	else
		OPTS+=(USE_UPNP=)
	fi
	use ipv6 || OPTS+=("USE_IPV6=-")

	# Workaround for bug #440034
	share/genbuild.sh src/obj/build.h

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}"
}

src_install() {
	dobin src/${PN}
	dodoc doc/README.md
}
