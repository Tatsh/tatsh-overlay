# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="GTA III decompiled and re-built."
HOMEPAGE="https://web.archive.org/web/20210906122012/https://github.com/GTAmodding/re3"
SHA="3233ffe1c4b99e8efb4c41c6794b4fce880cf503"
LIBRW_SHA="5501c4fdc7425ff926be59369a13593bb6c81b54"
SRC_URI="https://web.archive.org/web/20210906122012/https://github.com/GTAmodding/${PN}/archive/${SHA}.zip -> ${P}.zip
	https://github.com/aap/librw/archive/${LIBRW_SHA}.tar.gz -> ${PN}-librw-${LIBRW_SHA}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE="opus sanitizer sndfile"

DEPEND="media-libs/libsndfile
	media-libs/openal
	media-libs/glew:0
	media-sound/mpg123-base
	>=media-libs/glfw-3.3.2
	opus? ( media-libs/opus media-libs/opusfile )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/${PN}-xdg.patch"
	"${FILESDIR}/relcs-link-x11.patch"
)

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
	cat << "EOF" >> src/core/config.h
#define BIND_VEHICLE_FIREWEAPON
#define NEW_WALK_AROUND_ALGORITHM
#define PEDS_REPORT_CRIMES_ON_PHONE
#define SIMPLIER_MISSIONS
#define VC_PED_PORTS
#define XDG_ROOT
#define USE_DEBUG_SCRIPT_LOADER
EOF
}

src_configure() {
	local mycmakeargs=(
		"-DREVC_WITH_ASAN=$(usex sanitizer)"
		"-DREVC_WITH_LIBSNDFILE=$(usex sndfile)"
		"-DREVC_WITH_OPUS=$(usex opus)"
		-DLIBRW_PLATFORM=GL3
		-DBUILD_SHARED_LIBS=OFF
		-DLIBRW_TOOLS=OFF
		-DRE3_AUDIO=OAL
		-DRE3_VENDORED_LIBRW=ON
		-DRE3_INSTALL=ON
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr/share/${PN}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
	dosym ."./share/${PN}/${PN}" /usr/bin/re3
}

pkg_postinst() {
	einfo
	einfo "Store your GTA III game files from an installation in the"
	einfo "following directory (create if necessary):"
	einfo
	# shellcheck disable=SC2088
	einfo "~/.local/share/re3"
	einfo
}
