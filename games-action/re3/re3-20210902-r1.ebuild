# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="GTA III decompiled and re-built."
HOMEPAGE="https://github.com/GTAmodding/re3"
MY_RE3_HASH="3233ffe1c4b99e8efb4c41c6794b4fce880cf503"
MY_LIBRW_HASH="5501c4fdc7425ff926be59369a13593bb6c81b54"
SRC_URI="https://web.archive.org/web/20210906122012/https://github.com/GTAmodding/${PN}/archive/${MY_RE3_HASH}.zip -> ${P}.zip
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
	opus? ( media-libs/opus media-libs/opusfile )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_RE3_HASH}"

PATCHES=(
	"${FILESDIR}/${PN}-xdg.patch"
	"${FILESDIR}/relcs-link-x11.patch"
)

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
	echo '#define XDG_ROOT' >> src/core/config.h
}

src_configure() {
	local mycmakeargs=(
		-DRE3_WITH_ASAN=$(usex sanitizer)
		-DRE3_WITH_OPUS=$(usex opus)
		-DLIBRW_PLATFORM=GL3
		-DBUILD_SHARED_LIBS=OFF
		-DLIBRW_TOOLS=OFF
		-DRE3_AUDIO=OAL
		-DRE3_VENDORED_LIBRW=ON
		-DRE3_WITH_LIBSNDFILE=$(usex sndfile)
		-DRE3_INSTALL=ON
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr/share/${PN}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
	dosym ../share/${PN}/${PN} /usr/bin/re3
}

pkg_postinst() {
	einfo
	einfo "Store your GTA III game files from an installation in the"
	einfo "following directory (create if necessary):"
	einfo
	einfo "~/.local/share/re3"
	einfo
}
