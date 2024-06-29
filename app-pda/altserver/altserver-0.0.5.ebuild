# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AltServer for AltStore, but on-device."
HOMEPAGE="https://github.com/NyaMisty/AltServer-Linux"
MY_PN="AltServer-Linux"
IDEVICEINSTALLER_SHA="534ddefac4b7118bd4781cd91f8781d8727ff49a"
LIBIMOBILEDEVICE_SHA="c6f89deac00347faa187f2f5296e32840c4f26b4"
LIBIMOBILEDEVICE_GLUE_SHA="c2e237ab5449b42461639c8e1eabbc61d0c386b7"
LIBPLIST_SHA="db93bae96d64140230ad050061632531644c46ad"
LIBUSBMUXD_SHA="36ffb7ab6e2a7e33bd1b56398a88895b7b8c615a"
UPSTREAM_SHA="071b1dda13ff4d3623b1e3680ec93dd670ecaf45"
SRC_URI="https://github.com/NyaMisty/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rileytestut/AltServer-Windows/archive/${UPSTREAM_SHA}.tar.gz -> ${PN}-upstream-${UPSTREAM_SHA:0:7}.tar.gz
	https://github.com/libimobiledevice/ideviceinstaller/archive/${IDEVICEINSTALLER_SHA}.tar.gz -> ${PN}-ideviceinstaller-${IDEVICEINSTALLER_SHA:0:7}.tar.gz
	https://github.com/libimobiledevice/libimobiledevice-glue/archive/${LIBIMOBILEDEVICE_GLUE_SHA}.tar.gz -> ${PN}-libimobiledevice-glue-${LIBIMOBILEDEVICE_GLUE_SHA:0:7}.tar.gz
	https://github.com/libimobiledevice/libimobiledevice/archive/${LIBIMOBILEDEVICE_SHA}.tar.gz -> ${PN}-libimobiledevice-${LIBIMOBILEDEVICE_SHA:0:7}.tar.gz
	https://github.com/libimobiledevice/libplist/archive/${LIBPLIST_SHA}.tar.gz -> ${PN}-libplist-${LIBPLIST_SHA:0:7}.tar.gz
	https://github.com/libimobiledevice/libusbmuxd/archive/${LIBUSBMUXD_SHA}.tar.gz -> ${PN}-libusbmuxd-${LIBUSBMUXD_SHA:0:7}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/cpprestsdk
	dev-libs/boost
	dev-libs/libzip
	dev-libs/openssl
	sys-apps/util-linux
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/clang"

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}/altserver-altsign.patch"
	"${FILESDIR}/altserver-libplist.patch"
	"${FILESDIR}/altserver-misc.patch"
)

src_prepare() {
	rmdir upstream_repo libraries/ideviceinstaller libraries/libimobiledevice \
		libraries/lib{imobiledevice-glue,plist,usbmuxd} || die
	mv "${WORKDIR}/AltServer-Windows-${UPSTREAM_SHA}" "${S}/upstream_repo" || die
	mv "${WORKDIR}/ideviceinstaller-${IDEVICEINSTALLER_SHA}" "${S}/libraries/ideviceinstaller" || die
	mv "${WORKDIR}/libimobiledevice-${LIBIMOBILEDEVICE_SHA}" "${S}/libraries/libimobiledevice" || die
	mv "${WORKDIR}/libimobiledevice-glue-${LIBIMOBILEDEVICE_GLUE_SHA}" "${S}/libraries/libimobiledevice-glue" || die
	mv "${WORKDIR}/libplist-${LIBPLIST_SHA}" "${S}/libraries/libplist" || die
	mv "${WORKDIR}/libusbmuxd-${LIBUSBMUXD_SHA}" "${S}/libraries/libusbmuxd" || die
	default
}

src_install() {
	local exec=$(find . -maxdepth 1 -type f -executable -name 'AltServer-*' | head -n 1)
	newbin "$exec" AltServer
	einstalldocs
}
