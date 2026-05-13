# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="AltServer for AltStore, but on-device."
HOMEPAGE="https://github.com/NyaMisty/AltServer-Linux"
MY_PN="AltServer-Linux"
SHA="78764512b735e7a731ef4ff36aca8d80dbd8d7c8"
UPSTREAM_SHA="071b1dda13ff4d3623b1e3680ec93dd670ecaf45"
SRC_URI="https://github.com/NyaMisty/${MY_PN}/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/rileytestut/AltServer-Windows/archive/${UPSTREAM_SHA}.tar.gz -> ${PN}-upstream-${UPSTREAM_SHA:0:7}.tar.gz"

S="${WORKDIR}/${MY_PN}-${SHA}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-pda/libimobiledevice
	app-pda/libimobiledevice-glue
	app-pda/libplist
	app-pda/libusbmuxd
	dev-cpp/cpprestsdk
	dev-libs/boost
	dev-libs/corecrypto
	dev-libs/libzip
	dev-libs/openssl
	sys-apps/util-linux
	sys-libs/zlib[minizip]
	virtual/zlib"
RDEPEND="${DEPEND}"
BDEPEND="llvm-core/clang
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-0001-build-add-use_system_libimob.patch"
	"${FILESDIR}/${PN}-0002-build-add-use_system_minizip.patch"
	"${FILESDIR}/${PN}-altsign.patch"
	"${FILESDIR}/${PN}-libplist-from-memory.patch"
)

src_prepare() {
	# Replace the vendored AltServer-Windows reference source that
	# upstream_repo/ symlinks to. The vendored libimobiledevice stack
	# (libraries/libimobiledevice, libraries/libimobiledevice-glue,
	# libraries/libplist, libraries/libusbmuxd) is no longer required at
	# build time because USE_SYSTEM_LIBIMOBILEDEVICE=1 routes the build
	# through pkg-config against the system installation.
	rmdir upstream_repo || die
	mv "${WORKDIR}/AltServer-Windows-${UPSTREAM_SHA}" "${S}/upstream_repo" || die
	default
}

src_compile() {
	emake USE_SYSTEM_LIBIMOBILEDEVICE=1 USE_SYSTEM_MINIZIP=1
}

src_install() {
	local exec
	exec=$(find . -maxdepth 1 -type f -executable -name 'AltServer-*' | head -n 1)
	[[ -n ${exec} ]] || die "AltServer binary not found"
	newbin "${exec}" AltServer
	systemd_dounit "${FILESDIR}/altserver.service"
	einstalldocs
}
