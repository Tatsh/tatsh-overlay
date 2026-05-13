# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fcaps systemd

DESCRIPTION="The Pi-hole FTL engine (DNS, embedded web UI)"
HOMEPAGE="https://github.com/pi-hole/FTL"
SRC_URI="https://github.com/pi-hole/FTL/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/FTL-${PV}"

LICENSE="EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/gmp
	dev-libs/libunistring
	dev-libs/nettle
	net-dns/libidn2
	sys-libs/libtermcap-compat
	sys-libs/readline:="
RDEPEND="${DEPEND}"
BDEPEND="app-editors/vim-core" # needed for xxd

PATCHES=(
	"${FILESDIR}/${P}-0001-cmake-gate-install-time-setc.patch"
)

FILECAPS=(
	'cap_net_bind_service,cap_net_admin,cap_net_raw,cap_sys_nice,cap_chown,cap_sys_time' usr/bin/pihole-FTL
)

src_prepare() {
	sed -re 's/-Werror //g' -i src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	# Upstream pins mbedtls to a private fork whose API differs from the
	# stock 3.x releases (e.g. mbedtls_x509write_crt_pem has 3 vs 5 args).
	# Disable the embedded webserver's TLS to avoid that ABI mismatch; the
	# web UI still serves over plain HTTP. Users wanting HTTPS should put a
	# reverse proxy (caddy, nginx, etc.) in front of pihole-FTL.
	local mycmakeargs=(
		-DSKIP_INSTALL_PRIVILEGED_STEPS=ON
		-DUSE_MBED_TLS=OFF
	)
	cmake_src_configure
}

src_compile() {
	export GIT_BRANCH=master GIT_TAG=v${PV} GIT_VERSION=v${PV}
	cmake_src_compile
}

src_install() {
	cmake_src_install
	doinitd "${FILESDIR}/pihole-FTL"
	systemd_dounit "${FILESDIR}/pihole-FTL.service"
}
