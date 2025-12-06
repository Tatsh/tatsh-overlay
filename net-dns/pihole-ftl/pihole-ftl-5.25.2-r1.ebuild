# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fcaps systemd

DESCRIPTION="The Pi-hole FTL engine"
HOMEPAGE="https://github.com/pi-hole/FTL"
SRC_URI="https://github.com/pi-hole/FTL/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/FTL-${PV}"
LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/gmp
	dev-libs/nettle
	net-dns/libidn
	sys-libs/readline
	sys-libs/libtermcap-compat"
RDEPEND="${DEPEND}"
BDEPEND="app-editors/vim-core" # needed for xxd

PATCHES=( "${FILESDIR}/${PN}-0001-fixes.patch" )

FILECAPS=(
	'cap_net_bind_service,cap_net_admin,cap_net_raw,cap_sys_nice' usr/bin/pihole-FTL
)

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
