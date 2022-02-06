# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fork of sm64-port with additional features (alpha branch)."
HOMEPAGE="https://github.com/Render96/Render96ex/tree/alpha"
SHA="8e2eea106dd94e5c05b5f08ad989ace01efe701e"
MODELS_SHA="f4f438447748782b7c824cee903594706a3941e2"
TEXTURES_SHA="7ad93cfbdde449cc07e86ebf17985ee9c157f36f"
MY_PN="Render96ex"
SRC_URI="https://github.com/Render96/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz
	textures? ( https://github.com/pokeheadroom/RENDER96-HD-TEXTURE-PACK/archive/${TEXTURES_SHA}.tar.gz -> ${PN}-texture-pack-${TEXTURES_SHA:0:7}.tar.gz )
	models? ( https://github.com/Render96/ModelPack/archive/${MODELS_SHA}.tar.gz -> ${PN}-models-vanilla-${MODELS_SHA:0:7}.tar.gz )
	us? ( sm64.us.z64 )
	eu? ( sm64.eu.z64 )
	jp? ( sm64.jp.z64 )"
RESTRICT="fetch"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+goddard
	+models
	+texture-fix
	+textures
	debug
	discord
	eu
	jp
	us"
REQUIRED_USE="|| ( eu jp us )"

DEPEND="media-libs/glew:= media-libs/libsdl2 virtual/opengl"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/p7zip"

S="${WORKDIR}/${MY_PN}-${SHA}"

pkg_nofetch() {
	if use us; then
		einfo "Please place a copy of your North American version ROM of Super Mario 64 in your ISTDIR directory and name it sm64.us.z64"
	elif use jp; then
		einfo "Please place a copy of your Japanese version ROM of Super Mario 64 in your DISTDIR irectory and name it sm64.jp.z64"
	elif use eu; then
		einfo "Please place a copy of your European version ROM of Super Mario 64 in your DISTDIR nd name it sm64.eu.z64"
	fi
	einfo "The ROM must be in Z64 format. If the checksums do not match, it is possibly a V64 ROM that must be byteswapped. Use the tool here to convert: https://hack64.net/tools/swapper.php"
}

src_unpack() {
	local archive
	for archive in ${A}; do
		case "${archive}" in
			*.7z)
				echo ">>> Unpacking ${archive} to ${WORKDIR}"
				7z x -bd -y "-o${WORKDIR}" -- "${DISTDIR}/${archive}" >/dev/null 2>&1 || die
				;;
			*.z64)
				;;
			*)
				unpack "${archive}"
				;;
		esac
	done
}

src_prepare() {
	local i
	for i in "${DISTDIR}/sm64."*.z64; do
		cp "${i}" "$(basename ${i/sm64/baserom})" || die
	done
	sed -r -e 's/^GIT_HASH=.*/GIT_HASH?=/' -i Makefile || die
	./extract_assets.py $(get_version) || die
	if use models; then
		cp -fR "${WORKDIR}/ModelPack-${MODELS_SHA}/Render96/actors/"* actors/ || die
	fi
	if use goddard; then
		cp -fR "${WORKDIR}/ModelPack-${MODELS_SHA}/Goddard/src/goddard/"* src/goddard/ || die
	fi
	default
}

get_version() {
	use us && echo us
	use eu && echo eu
	use jp && echo jp
}

get_basedir() {
	echo "${EPREFIX}/usr/$(get_libdir)/${PN}"
}

src_compile() {
	local version=us
	use eu && version=eu
	use jp && version=jp
	emake \
		"BASEDIR=$(get_basedir)" \
		DEBUG=$(usex debug 1 0) \
		DISCORDRPC=$(usex discord 1 0) \
		GIT_HASH=${SHA} \
		NOEXTRACT=1 \
		TEXTURE_FIX=$(usex texture-fix 1 0) \
		VERSION=$(get_version)
}

src_install() {
	newbin build/*_pc/sm64.$(get_version).f3dex2e ${PN}-sm64
	insinto /usr/$(get_libdir)/${PN}
	doins -r "build/$(get_version)_pc/$(get_basedir)/"*
	if use textures; then
		doins -r "${WORKDIR}/RENDER96-HD-TEXTURE-PACK-${TEXTURES_SHA}/gfx"
	fi
	einstalldocs
}
