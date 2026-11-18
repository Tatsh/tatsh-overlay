# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-prboom"
LIBRETRO_COMMIT_SHA="4849268e7342494193f2bbf2d0128a751cf58da7"

inherit libretro libretro-core toolchain-funcs

DESCRIPTION="libretro implementation of PrBoom. (Doom)"
HOMEPAGE="https://github.com/libretro/libretro-prboom"
# The regression lanes play an IWAD; upstream CI uses this Freedoom release.
SRC_URI+=" test? ( https://github.com/freedoom/freedoom/releases/download/v0.13.0/freedoom-0.13.0.zip )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="games-emulation/libretro-info"
BDEPEND="test? ( app-arch/unzip )"

src_test() {
	local lane
	for lane in tests/*/; do
		grep -q '^check:' "${lane}Makefile" 2>/dev/null || continue
		# Content PWADs the lanes generate are matched with an IWAD beside them.
		cp "${WORKDIR}/freedoom-0.13.0/freedoom1.wad" "${lane}" || die
		emake -C "${lane}" check CC="$(tc-getCC)" CORE="${LIBRETRO_CORE_LIB_FILE[0]}" \
			IWAD="${S}/${lane}freedoom1.wad"
	done
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/prboom_libretro/
	doins "${S}"/prboom.wad
	libretro-core_src_install
}
