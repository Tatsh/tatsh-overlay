# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Shell extension for file managers to manage game ROMs and disc images."
HOMEPAGE="https://github.com/GerbilSoft/rom-properties"
SRC_URI="https://github.com/GerbilSoft/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="achievements cli crypt gtk kde nls lto lz4 lzo pvr unice68 xbox-360 xfce xml zstd"

DEPEND="
	media-libs/libjpeg-turbo
	media-libs/libpng
	sys-libs/zlib
	gtk? ( x11-libs/gtk+:3 )
	lz4? ( app-arch/lz4 )
	lzo? ( dev-libs/lzo )
	nls? ( sys-devel/gettext )
	xfce? ( xfce-extra/tumbler[curl] )
	xml? ( dev-libs/tinyxml2 )
	zstd? ( app-arch/zstd )"
REQUIRED_USE="|| ( cli gtk kde xfce )"
RDEPEND="${DEPEND}"

DOCS=( README.md NEWS.md )

src_prepare() {
	sed -e '/assert(img != INVALID_IMG_PTR);/d' -i src/librpbase/RomData.cpp || die
	{ head -n 17 doc/CMakeLists.txt > new && mv new doc/CMakeLists.txt; } || die
	sed -r -e '/COMPILING\.md/d' \
		-e 's/DIR_INSTALL_DOC/DIR_INSTALL_SHARE/g' \
		-i doc/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_CLI=$(usex cli)
		-DBUILD_GTK3=$(usex gtk)
		-DBUILD_KF5=$(usex kde)
		-DBUILD_XFCE=$(usex xfce)
		-DENABLE_ACHIEVEMENTS=$(usex achievements)
		-DENABLE_DECRYPTION=$(usex crypt)
		-DENABLE_JPEG=ON
		-DENABLE_LIBMSPACK=$(usex xbox-360)
		-DENABLE_LTO=$(usex lto)
		-DENABLE_LZ4=$(usex lz4)
		-DENABLE_LZO=$(usex lzo)
		-DENABLE_NLS=$(usex nls)
		-DENABLE_PVRTC=$(usex pvr)
		-DENABLE_UNICE68=$(usex unice68)
		-DENABLE_XML=$(usex xml)
		-DENABLE_ZSTD=$(usex zstd)
		-DINSTALL_APPARMOR=OFF
		-DSPLIT_DEBUG=NO
		-DUSE_INTERNAL_JPEG=NO
		-DUSE_INTERNAL_LZ4=NO
		-DUSE_INTERNAL_LZO=NO
		-DUSE_INTERNAL_PNG=NO
		-DUSE_INTERNAL_XML=OFF
		-DUSE_INTERNAL_ZLIB=NO
		-DUSE_INTERNAL_ZSTD=NO
		-Wno-dev
	)
	cmake_src_configure
}
