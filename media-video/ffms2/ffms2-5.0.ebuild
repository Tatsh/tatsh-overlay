# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An FFmpeg based library and VapourSynth plugin for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
# The test/googletest submodule, and a snapshot of the samples "make test-sync"
# downloads from https://storage.googleapis.com/ffms2tests.
GTEST_COMMIT="f5260ae757a681566d8f7d0558b8dc0551036506"
SRC_URI="https://github.com/FFMS/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	test? (
		https://github.com/google/googletest/archive/${GTEST_COMMIT}.tar.gz
			-> googletest-${GTEST_COMMIT}.gh.tar.gz
		https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-test-samples.tar.xz
	)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"
RESTRICT="!test? ( test )"

DEPEND="media-video/ffmpeg virtual/zlib"
RDEPEND="${DEPEND}"

src_prepare () {
	if use test; then
		if [[ -d test/googletest ]]; then
			rmdir test/googletest || die
		fi
		mv "${WORKDIR}/googletest-${GTEST_COMMIT}" test/googletest || die
	fi
	mkdir -p src/config || die
	eautoreconf
	default
}

src_configure() {
	econf "$(use_enable debug)"
}

src_test() {
	emake test-run SAMPLES_DIR="${WORKDIR}/${P}-test-samples"
}

src_install () {
	default
	keepdir "/usr/$(get_libdir)/vapoursynth/"
	dosym -r "/usr/$(get_libdir)/libffms2.so" "/usr/$(get_libdir)/vapoursynth/libffms2.so"
	rm "${D}/usr/$(get_libdir)/"*.la || die
	einstalldocs
}
