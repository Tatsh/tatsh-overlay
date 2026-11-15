# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/stella2014-libretro"
LIBRETRO_COMMIT_SHA="7d1361e407e63f29e52892655069e5fb4096e691"
inherit libretro-core toolchain-funcs

DESCRIPTION="Stella 2014 libretro port (Atari 2600 VCS)"
HOMEPAGE="https://github.com/libretro/stella2014-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_test() {
	# test/run_tests.sh also runs build_configs.sh, a gate that fails on any compiler
	# warning; run its three harnesses against the built core directly.
	local t
	for t in determinism_harness malformed_state arm_cart_determinism; do
		# shellcheck disable=SC2086
		"$(tc-getCC)" ${CFLAGS} ${LDFLAGS} -o "${T}/${t}" "test/${t}.c" \
			-I libretro-common/include -ldl || die
		"${T}/${t}" "${LIBRETRO_CORE_LIB_FILE[0]}" || die "${t} failed"
	done
}
