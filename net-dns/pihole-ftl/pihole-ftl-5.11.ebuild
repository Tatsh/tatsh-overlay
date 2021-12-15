# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="The Pi-hole FTL engine"
HOMEPAGE="https://github.com/pi-hole/FTL"
SRC_URI="https://github.com/pi-hole/FTL/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/gmp
	dev-libs/nettle
	net-dns/libidn
	sys-libs/readline"
RDEPEND="${DEPEND}"

S="${WORKDIR}/FTL-${PV}"

src_prepare() {
	sed -r -e 's/-Werror //g' \
		-e 's/lib(hogweed|gmp|nettle|idn|readline|history).*/\1)/g' \
		-e '/find_library\(LIBTERMCAP.*/d' \
		-e 's/\$\{LIBTERMCAP\}//g' \
		-e 's/ AND LIBTERMCAP//g' \
		-i src/CMakeLists.txt || die
	sed -r -e 's/ AND LIBTERMCAP//g' -i src/lua/CMakeLists.txt || die
	sed     -e 's%/etc/pihole/gravity.db%/var/lib/pihole/gravity.db%g' \
		-e 's%/etc/pihole/macvendor.db%/var/lib/pihole/macvendor.db%g' \
		-e 's%/etc/pihole/pihole-FTL.db%/var/lib/pihole/pihole-FTL.db%g' \
		-i -- $(grep -rl '/etc/pihole/[[:alpha:]-]*.db' .) || die
	cmake_src_prepare
}

src_compile() {
	export GIT_BRANCH=master GIT_TAG=v${PV} GIT_VERSION=v${PV}
	cmake_src_compile
}
