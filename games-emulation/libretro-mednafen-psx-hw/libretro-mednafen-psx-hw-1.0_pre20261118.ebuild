# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-psx-libretro"
LIBRETRO_COMMIT_SHA="71ee81e77acd49296ecf4a683f5a61568ba80bf9"

inherit libretro-core toolchain-funcs

DESCRIPTION="Standalone port/fork of Mednafen PSX to the Libretro API"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
DEPEND="media-libs/libglvnd"
IUSE="opengl vulkan cdrom test"
RESTRICT="!test? ( test )"

src_compile() {
	MYEMAKEARGS=(
		"$(usex cdrom 'HAVE_CDROM=1' 'HAVE_CDROM=0')"
		HAVE_LIGHTREC=1
	)
	if  use opengl && use vulkan; then
		MYEMAKEARGS+=( "HAVE_HW=1" )
	else
		MYEMAKEARGS+=(
			"$(usex opengl 'HAVE_OPENGL=1' '')"
			"$(usex vulkan 'HAVE_VULKAN=1' '')"
		)
	fi
	libretro-core_src_compile
}

src_test() {
	# Each tools/*/run.sh builds a harness against the core. Not run here: chd needs
	# chdman (games-emulation/mame); hdr_display and lightrec need a PlayStation BIOS;
	# core_options checks the HDR option, which only the Vulkan renderer registers;
	# crop_window and deinterlace target the software core (libretro-mednafen-psx).
	# The harnesses also rerun under ASan, which objects to the sandbox's LD_PRELOAD;
	# some set their own ASAN_OPTIONS.
	sed -i -e 's/ -Werror\b//' -e 's/ASAN_OPTIONS=/&verify_asan_link_order=0:/g' \
		tools/*/run.sh || die
	local -x ASAN_OPTIONS=verify_asan_link_order=0
	local harness name
	for harness in tools/*/run.sh; do
		name=${harness#tools/}
		name=${name%/run.sh}
		case ${name} in
			chd|crop_window|deinterlace|hdr_display|lightrec) continue ;;
			core_options) use vulkan || continue ;;
		esac
		einfo "Running ${name}"
		CC="$(tc-getCC)" sh "${harness}" "${LIBRETRO_CORE_LIB_FILE[0]}" ||
			die "${name} failed"
	done
}
