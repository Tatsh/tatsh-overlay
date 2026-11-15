# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Multi-system emulator focusing on accuracy and preservation"
HOMEPAGE="https://github.com/ares-emulator/ares https://ares-emu.net/"
SRC_URI="https://github.com/ares-emulator/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ares-emulator/ares-deps/releases/download/2026-04-23/ares-deps-linux-universal.tar.xz -> ${P}-deps.tar.xz"

LICENSE="MPL-2.0 MIT BSD public-domain ZLIB BSD-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/glib
	media-libs/alsa-lib
	media-libs/libao
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/libsdl3
	media-libs/openal
	virtual/udev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/pango"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir -p .deps || die
	mv "${WORKDIR}/ares-deps-linux-universal" .deps/ || die
	# _check_dependencies() only skips its own download when this marker matches
	# the hash in deps.json. Read it from there rather than repeating it here,
	# so bumping the bundle cannot leave the two disagreeing.
	local hash
	hash=$(sed -n 's/.*"linux-universal": "\([0-9a-f]\{64\}\)".*/\1/p' deps.json | head -n1)
	[[ -n ${hash} ]] || die 'Could not read the ares-deps hash from deps.json'
	printf '%s' "${hash}" > .deps/.dependency_prebuilt_universal.sha256 || die
	cmake_src_prepare
}

src_test() {
	# The i8080 harness is the only processor test with its ROMs in the tree
	# (the arm7tdmi and m68000 ones clone SingleStepTests). It is an optional
	# target alongside extra tools, so build it in a separate tree.
	local BUILD_DIR="${WORKDIR}/${P}_test"
	local mycmakeargs=( -DARES_BUILD_OPTIONAL_TARGETS=ON )
	cmake_src_configure
	cmake_build i8080
	local harness
	harness=$(find "${BUILD_DIR}" -type f -name i8080 -perm -u+x -print -quit) || die
	[[ -n ${harness} ]] || die "i8080 harness not built"
	pushd tests/i8080 >/dev/null || die
	"${harness}" | tee "${T}/i8080.log" || die
	popd >/dev/null || die
	# The harness always exits 0; check what each CP/M exerciser reports.
	grep -q 'CPU IS OPERATIONAL' "${T}/i8080.log" || die "TST8080 failed"
	grep -q 'CPU TESTS OK' "${T}/i8080.log" || die "CPUTEST failed"
	grep -q 'Preliminary tests complete' "${T}/i8080.log" || die "8080PRE failed"
	grep -q "Tests complete" "${T}/i8080.log" || die "8080EXM did not finish"
	if grep -q 'ERROR' "${T}/i8080.log"; then
		die "8080EXM reported an error"
	fi
}
