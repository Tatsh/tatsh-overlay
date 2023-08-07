# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake systemd

DESCRIPTION="The Pi-hole FTL engine"
HOMEPAGE="https://github.com/pi-hole/FTL"
SRC_URI="https://github.com/pi-hole/FTL/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/gmp
	dev-libs/nettle
	net-dns/libidn
	sys-libs/readline
	sys-libs/libtermcap-compat"
RDEPEND="${DEPEND}"

S="${WORKDIR}/FTL-${PV}"

PATCHES=( "${FILESDIR}/${PN}-0001-fixes.patch" )

src_prepare() {
	sed -re 's/-Werror //g' -i src/CMakeLists.txt || die
	cp "${FILESDIR}/pihole-FTL.conf" . || die
	sed -r -e "s/@EPREFIX@/${EPREFIX}/g" -i pihole-FTL.conf || die
	cmake_src_prepare
}

src_compile() {
	export GIT_BRANCH=master GIT_TAG=v${PV} GIT_VERSION=v${PV}
	cmake_src_compile
}

src_install() {
	cmake_src_install
	doinitd "${FILESDIR}/pihole-FTL"
	systemd_dounit "${FILESDIR}/pihole-FTL.service"
	insinto /etc/pihole
	doins pihole-FTL.conf
}
