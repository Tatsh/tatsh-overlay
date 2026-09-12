# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic xdg

# Upstream's only tag is a rolling "continuous" one, so this pins a commit.
MY_COMMIT="6141927738a64810a687a27eb61f5760d36733a5"
# Submodules. Everything else is resolved from the system with
# DOWNLOAD_DEPENDENCIES=OFF.
LIBSMACKER_COMMIT="b3d4e97e0c95d5259d858495a5addd2d93bce5f4"
MINIAUDIO_COMMIT="9634bedb5b5a2ca38c1ee7108a9358a4e233f14d"
# libweaver is five files out of SIEdit, compiled by 3rdparty/CMakeLists.txt.
SIEDIT_COMMIT="abb6d47139d7a03c5c1bad9b89e2267849e27904"

DESCRIPTION="Portable reimplementation of LEGO Island."
HOMEPAGE="https://github.com/isledecomp/isle-portable"
SRC_URI="https://github.com/isledecomp/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz
	https://github.com/foxtacles/libsmacker/archive/${LIBSMACKER_COMMIT}.tar.gz
	-> libsmacker-${LIBSMACKER_COMMIT}.tar.gz
	https://github.com/mackron/miniaudio/archive/${MINIAUDIO_COMMIT}.tar.gz
	-> miniaudio-${MINIAUDIO_COMMIT}.tar.gz
	https://github.com/isledecomp/SIEdit/archive/${SIEDIT_COMMIT}.tar.gz
	-> SIEdit-${SIEDIT_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/iniparser:=
	dev-qt/qtbase:6[gui,widgets]
	media-libs/libsdl3
	net-libs/libwebsockets[client]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/python:*"

PATCHES=( "${FILESDIR}/${P}-vendor-libweaver.patch" )

src_prepare() {
	rm -rf 3rdparty/libsmacker 3rdparty/miniaudio || die
	mv "${WORKDIR}/libsmacker-${LIBSMACKER_COMMIT}" 3rdparty/libsmacker || die
	mv "${WORKDIR}/miniaudio-${MINIAUDIO_COMMIT}" 3rdparty/miniaudio || die

	cmake_src_prepare

	sed -i -e "s|@LIBWEAVER_SOURCE_DIR@|${WORKDIR}/SIEdit-${SIEDIT_COMMIT}|" \
		3rdparty/CMakeLists.txt || die
	grep -q '@LIBWEAVER_SOURCE_DIR@' 3rdparty/CMakeLists.txt &&
		die "failed to substitute the libweaver source directory"
}

src_configure() {
	# miniwin's OpenGL ES 2 backend declares TextureDestroyContextGLS2
	# differently in two translation units, which LTO reports as -Wodr.
	filter-lto

	local mycmakeargs=(
		# Resolve SDL3, iniparser and libwebsockets from the system instead
		# of fetching them at configure time.
		-DDOWNLOAD_DEPENDENCIES=OFF
		-DISLE_BUILD_ASSETS=OFF
	)

	cmake_src_configure
}

pkg_postinst() {
	elog "This needs the data files from an original LEGO Island install."
}
