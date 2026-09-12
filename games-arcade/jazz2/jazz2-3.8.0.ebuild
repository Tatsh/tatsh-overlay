# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="jazz2-native"

DESCRIPTION="Open-source reimplementation of Jazz Jackrabbit 2."
HOMEPAGE="https://deat.tk/jazz2/ https://github.com/deathkiller/jazz2-native"
SRC_URI="https://github.com/deathkiller/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="angelscript +openmpt webp"

# The engine is nCine, vendored under Sources/. enet, ixwebsocket, jsoncpp,
# parallel_hashmap and pdqsort are vendored under Sources/Dependencies and are
# not packaged separately.
RDEPEND="
	media-libs/glew:=
	media-libs/libglvnd
	media-libs/libpng:=
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/openal
	virtual/zlib
	angelscript? ( dev-libs/angelscript:= )
	openmpt? ( media-libs/libopenmpt:= )
	webp? ( media-libs/libwebp:= )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		# Every dependency is either packaged or vendored; without this the
		# build fetches sources over the network.
		-DNCINE_DOWNLOAD_DEPENDENCIES=OFF
		# There is no git metadata in a release archive.
		-DNCINE_VERSION_FROM_GIT=OFF
		# Copies the system libraries it linked against next to the binary.
		-DNCINE_COPY_DEPENDENCIES=OFF
		# Portage does the stripping and the debug symbol splitting.
		-DNCINE_STRIP_BINARIES=OFF
		-DNCINE_LINUX_PACKAGE="${PN}"
		# Otherwise the content directory is looked for near the executable.
		-DNCINE_OVERRIDE_CONTENT_PATH="${EPREFIX}/usr/share/${PN}/Content/"
		-DNCINE_PREFERRED_BACKEND=SDL2
		"-DNCINE_WITH_ANGELSCRIPT=$(usex angelscript)"
		"-DNCINE_WITH_OPENMPT=$(usex openmpt)"
		"-DNCINE_WITH_WEBP=$(usex webp)"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Upstream puts the readme in share/doc/${PN}; Gentoo versions that path.
	rm -r "${ED}/usr/share/doc/${PN}" || die
	dodoc README.md
}

pkg_postinst() {
	elog "This is only the engine and its own assets. It needs the data files"
	elog "from a copy of Jazz Jackrabbit 2, which are not included."
	elog
	elog "Run the game once and it will ask where they are, or put them in"
	elog "the Source directory under .local/share/Jazz2 in your home."
}
