# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/pcsx_rearmed"
LIBRETRO_COMMIT_SHA="650460edb48f48863b08fd85de5111722242fed3"

inherit libretro-core

DESCRIPTION="libretro implementation of PCSX ReARMed. (PlayStation)"
HOMEPAGE="https://github.com/libretro/pcsx_rearmed"
KEYWORDS="~arm64"

LICENSE="GPL-2"
SLOT="0"

DEPEND="media-libs/libpng:0
	sys-libs/zlib"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
IUSE="neon"

src_prepare() {
	libretro-core_src_prepare
	sed -i configure \
		-e 's/*) echo "ERROR: unknown option $opt"; show_help="yes"/*) echo "unknown option $opt"/'
}

src_configure() {
	local myeconfenv=(
		$(usex arm "ARCH=arm" "")
		$(usex arm64 "ARCH=aarch64" "")
	)

	local myeconfargs=(
		--platform=libretro
	)

	if use arm || use arm64; then
		myeconfargs+=( 
			$(usex neon "--enable-neon --gpu=neon" "--disable-neon --gpu=unai")
		)
	fi

	export "${myeconfenv[@]}"
	econf "${myeconfargs[@]}"
}

src_compile() {
	use custom-cflags || filter-flags -O*

	local myemakeargs=(
		CC=$(tc-getCC)
		CXX=$(tc-getCXX)
		LD=$(tc-getLD)
		$(usex debug "DEBUG=1" "")
	)

	emake "${myemakeargs[@]}"
}

src_install() {
	mv "${S}"/libretro.so "${S}"/${LIBRETRO_CORE_NAME}_libretro.so
	libretro-core_src_install
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "scph5500.bin md5sum = 8dd7d5296a650fac7319bce665a6a53c"
		elog "scph5501.bin md5sum = 490f666e1afb15b7362b406ed1cea246"
		elog "scph5502.bin md5sum = 32736f17079d0b2b7024407c39bd3050"
		elog ""
		ewarn ""
	fi
}
