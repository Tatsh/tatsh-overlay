# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="GTA Vice City decompiled and re-built."
HOMEPAGE="https://github.com/GTAmodding/re3/tree/miami"
MY_REVC_HASH="9f6f9a7af3f68c3732b655cd31bd6f11a2f5bc22"
MY_LIBRW_HASH="41ae7b9b61c6736b34269df0f0350d1b5bcff4df"
SRC_URI="https://github.com/GTAmodding/re3/archive/${MY_REVC_HASH}.tar.gz -> ${P}.tar.gz
	https://github.com/aap/librw/archive/${MY_LIBRW_HASH}.tar.gz -> ${PN}-librw-${MY_LIBRW_HASH}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="extra opus sanitizer sndfile"

DEPEND="media-libs/libsndfile
	media-libs/openal
	media-libs/glew:0
	media-sound/mpg123
	>=media-libs/glfw-3.3.2
	opus? ( media-libs/opus )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/re3-${MY_REVC_HASH}"

# PATCHES=( "${FILESDIR}/${PN}-xdg.patch" )

src_unpack() {
	default
	cp -R "librw-${MY_LIBRW_HASH}"/* "${S}/vendor/librw/"
}

src_prepare() {
	cmake_src_prepare
	rm -fR vendor/{libsndfile,mpg123,openal-soft}
	# Other interesting variables:
	# - FINAL (which would enable USE_MY_DOCUMENTS)
	# - PC_PARTICLE
	echo '#define BIND_VEHICLE_FIREWEAPON' >> src/core/config.h
	echo '#define NEW_WALK_AROUND_ALGORITHM' >> src/core/config.h
	echo '#define PEDS_REPORT_CRIMES_ON_PHONE' >> src/core/config.h
	echo '#define SIMPLIER_MISSIONS' >> src/core/config.h
	echo '#define VC_PED_PORTS' >> src/core/config.h
# 	echo '#define XDG_ROOT' >> src/core/config.h
}

src_configure() {
	local mycmakeargs=(
		-DREVC_WITH_ASAN=$(usex sanitizer)
		-DREVC_WITH_LIBSNDFILE=$(usex sndfile)
		-DREVC_WITH_OPUS=$(usex opus)
		-DLIBRW_PLATFORM=GL3
		-DBUILD_SHARED_LIBS=OFF
		-DLIBRW_TOOLS=OFF
		-DREVC_AUDIO=OAL
	)
	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}/src/reVC"
	if use extra; then
		insinto /usr/share/${PN}/gamefiles
		doins -r gamefiles/*
	fi
	einstalldocs
}

pkg_postinst() {
	einfo
	einfo "Store your GTA III game files from an installation in the"
	einfo "following directory (create if necessary):"
	einfo
	einfo "~/.local/share/re3"
	einfo
}
