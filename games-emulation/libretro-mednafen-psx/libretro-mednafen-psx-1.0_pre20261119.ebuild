# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-psx-libretro"
LIBRETRO_COMMIT_SHA="cb4577ab8b2171d8c838e777bbd863e46e1815c4"

inherit libretro-core toolchain-funcs

DESCRIPTION="Standalone port/fork of Mednafen PSX to the Libretro API"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_test() {
	# Each tools/*/run.sh builds a harness against the core. Not run here:
	# chd needs chdman (games-emulation/mame); core_options checks the HDR option
	# only the hardware renderer (libretro-mednafen-psx-hw) registers; hdr_display
	# and lightrec need a PlayStation BIOS.
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
			chd|core_options|hdr_display|lightrec) continue ;;
		esac
		einfo "Running ${name}"
		CC="$(tc-getCC)" sh "${harness}" "${LIBRETRO_CORE_LIB_FILE[0]}" ||
			die "${name} failed"
	done
}
