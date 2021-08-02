# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="GTA Liberty City Stories decompiled and re-built."
HOMEPAGE="https://github.com/GTAmodding/re3/tree/lcs"
MY_RELCS_HASH="a481b900b948f5e9c40e334b789f663f7d6d5932"
MY_LIBRW_HASH="a5bc97232293250ae1bbd6ef6642532a541034ca"
SRC_URI="https://github.com/GTAmodding/re3/archive/${MY_RELCS_HASH}.tar.gz -> ${P}.tar.gz
	https://github.com/aap/librw/archive/${MY_LIBRW_HASH}.tar.gz -> ${PN}-librw-${MY_LIBRW_HASH}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="opus sanitizer sndfile"

DEPEND="media-libs/libsndfile
	media-libs/openal
	media-libs/glew:0
	media-sound/mpg123
	>=media-libs/glfw-3.3.2
	opus? ( media-libs/opus )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-link-x11.patch" )

S="${WORKDIR}/re3-${MY_RELCS_HASH}"

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
}

src_configure() {
	local mycmakeargs=(
		-DRELCS_WITH_ASAN=$(usex sanitizer)
		-DRELCS_WITH_LIBSNDFILE=$(usex sndfile)
		-DRELCS_WITH_OPUS=$(usex opus)
		-DLIBRW_PLATFORM=GL3
		-DBUILD_SHARED_LIBS=OFF
		-DLIBRW_TOOLS=OFF
		-DRELCS_AUDIO=OAL
		-DRELCS_INSTALL=ON
		-DRELCS_VENDORED_LIBRW=ON
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr/share/${PN}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dosym ../share/${PN}/reLCS /usr/bin/reLCS
	einstalldocs
}
