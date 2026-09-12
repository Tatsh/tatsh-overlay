# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

# Submodules that are not packaged separately. PortAudio and libsndfile are
# also submodules, but upstream prefers the host copies by default.
MIO_COMMIT="8b6b7d878c89e81614d05edca7936de41ccdd2da"
SF2CUTE_COMMIT="b42f23c75667d414ac024858f5303fb7dc17e0fd"

DESCRIPTION="Tools for Sega Dreamcast AICA sound driver formats."
HOMEPAGE="https://github.com/dakrk/manatools"
SRC_URI="https://github.com/dakrk/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/vimpunk/mio/archive/${MIO_COMMIT}.tar.gz
	-> mio-${MIO_COMMIT}.tar.gz
	https://github.com/gocha/sf2cute/archive/${SF2CUTE_COMMIT}.tar.gz
	-> sf2cute-${SF2CUTE_COMMIT}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	media-libs/libsndfile
	media-libs/portaudio
"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -rf third_party/mio third_party/sf2cute || die
	mv "${WORKDIR}/mio-${MIO_COMMIT}" third_party/mio || die
	mv "${WORKDIR}/sf2cute-${SF2CUTE_COMMIT}" third_party/sf2cute || die

	# sf2cute is a vendored build dependency, so none of it should be
	# installed. Its header install rule is broken here anyway: it reads
	# ${CMAKE_SOURCE_DIR}/include, which is manatools' source tree rather than
	# its own. Everything from the install section to the end of the file goes.
	sed -i -e '/^# Install and Export sf2cute$/,$d' \
		third_party/sf2cute/CMakeLists.txt || die
	# Drop the now-dangling comment banner the section started with.
	sed -i -e '${/^#=\+$/d}' third_party/sf2cute/CMakeLists.txt || die

	# sf2cute uses the fixed-width integer types without including <cstdint>,
	# which GCC 16 no longer provides transitively.
	local f
	while IFS= read -r -d '' f; do
		grep -q '#include <cstdint>' "${f}" && continue
		grep -qE '\b(u?int(8|16|32|64)_t)\b' "${f}" || continue
		sed -i -e '0,/^#include </s//#include <cstdint>\n#include </' "${f}" || die
	done < <(find third_party/sf2cute/include third_party/sf2cute/src -type f \
		\( -name '*.hpp' -o -name '*.cpp' -o -name '*.h' \) -print0)

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# Link the vendored sf2cute in statically rather than shipping it.
		-DBUILD_SHARED_LIBS=OFF
		# mio is vendored too; keep its headers out of the install set.
		-Dmio.installation=OFF
		-DUSE_HOST_PORTAUDIO=ON
		-DUSE_HOST_SNDFILE=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Internal static libraries linked into the tools; there is no public API.
	rm "${ED}/usr/$(get_libdir)"/lib{guicommon,manatools}.a || die
	rmdir "${ED}/usr/$(get_libdir)" || die
}
