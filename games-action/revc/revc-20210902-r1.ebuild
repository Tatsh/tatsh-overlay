# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="GTA Vice City decompiled and re-built."
HOMEPAGE="https://github.com/GTAmodding/re3/tree/miami"
SHA="a16fcd8d6a79e433c1c6e73d540f1bbe27e14164"
LIBRW_SHA="5501c4fdc7425ff926be59369a13593bb6c81b54"
SRC_URI="https://web.archive.org/web/20210905122315/https://github.com/GTAmodding/re3/archive/${SHA}.zip -> ${P}.zip
	https://github.com/aap/librw/archive/${LIBRW_SHA}.tar.gz -> ${PN}-librw-${LIBRW_SHA}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE="opus sanitizer sndfile"

DEPEND="media-libs/libsndfile
	media-libs/openal
	media-libs/glew:0
	media-sound/mpg123
	>=media-libs/glfw-3.3.2
	opus? ( media-libs/opus media-libs/opusfile )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/re3-${SHA}"

PATCHES=( "${FILESDIR}/relcs-link-x11.patch" )

src_unpack() {
	default
	cp -R "librw-${LIBRW_SHA}"/* "${S}/vendor/librw/"
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
		-DREVC_WITH_ASAN=$(usex sanitizer)
		-DREVC_WITH_LIBSNDFILE=$(usex sndfile)
		-DREVC_WITH_OPUS=$(usex opus)
		-DLIBRW_PLATFORM=GL3
		-DBUILD_SHARED_LIBS=OFF
		-DLIBRW_TOOLS=OFF
		-DREVC_AUDIO=OAL
		-DREVC_INSTALL=ON
		-DREVC_VENDORED_LIBRW=ON
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr/share/${PN}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dosym ../share/${PN}/reVC /usr/bin/reVC
	einstalldocs
}
