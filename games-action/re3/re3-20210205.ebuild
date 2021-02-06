# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GTA III decompiled and re-built."
HOMEPAGE="https://github.com/GTAmodding/re3"
MY_RE3_HASH="2bd8be587277af6a1239a19d0235888c85388f93"
MY_LIBRW_HASH="60a5ace16309ccd3d174a3ec14a1062540934066"
SRC_URI="https://github.com/GTAmodding/re3/archive/${MY_RE3_HASH}.tar.gz -> ${P}.tar.gz
	https://github.com/aap/librw/archive/${MY_LIBRW_HASH}.tar.gz -> ${PN}-librw-${MY_LIBRW_HASH}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra"

DEPEND="media-libs/libsndfile
	media-libs/openal
	media-libs/glew:0
	media-sound/mpg123
	>=media-libs/glfw-3.3.2"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/premake:5"

S="${WORKDIR}/${PN}-${MY_RE3_HASH}"

PATCHES=( "${FILESDIR}/${PN}-xdg.patch" )

src_unpack() {
	default
	cp -R "librw-${MY_LIBRW_HASH}"/* "${S}/vendor/librw/"
}

src_prepare() {
	default
	sed -i premake5.lua -e 's/.*staticruntime ".*//g' || die
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
	premake5 --with-librw gmake2
}

src_compile() {
	cd build
	if use amd64; then
		emake config=release_linux-amd64-librw_gl3_glfw-oal verbose=1
	elif use x86; then
		emake config=release_linux-x86-librw_gl3_glfw-oal verbose=1
	elif use arm; then
		emake config=release_linux-arm-librw_gl3_glfw-oal verbose=1
	elif use arm64; then
		emake config=release_linux-arm64-librw_gl3_glfw-oal verbose=1
	fi
}

src_install() {
	dobin bin/linux-*-librw_gl3_glfw-oal/Release/re3
	if use extra; then
		insinto /usr/share/re3/gamefiles
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
