# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/sekrit-twc/zimg"
	inherit git-r3
else
	# Snapshot of master: media-video/vapoursynth-78 uses the
	# chromatic_adaptation graph builder parameter, which is not in any
	# release as of 3.0.6.
	COMMIT="67e0603271c080e22c8429856dd4a8a56587e61e"
	# graphengine is a submodule, so it is absent from the GitHub archive.
	GRAPHENGINE_COMMIT="cb5b2ce13384ec2491f0c37256ea210034799f69"
	SRC_URI="https://github.com/sekrit-twc/zimg/archive/${COMMIT}.tar.gz
		-> ${P}.gh.tar.gz
		https://github.com/sekrit-twc/graphengine/archive/${GRAPHENGINE_COMMIT}.tar.gz
		-> graphengine-${GRAPHENGINE_COMMIT:0:8}.gh.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi
inherit autotools multilib-minimal

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"

LICENSE="WTFPL-2"
SLOT="0"
IUSE="debug static-libs test"
RESTRICT="!test? ( test )"
DEPEND="test? ( dev-cpp/gtest )"

src_prepare() {
	if [[ ${PV} != *9999* ]]; then
		rmdir graphengine || die
		mv "${WORKDIR}/graphengine-${GRAPHENGINE_COMMIT}" graphengine || die
	fi
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		"$(use_enable debug)" \
		"$(use_enable static-libs static)" \
		"$(use_enable test unit-test)"
}

multilib_src_install_all() {
	einstalldocs
	if ! use static-libs; then
		find "${ED}" -type f -name '*.la' -delete || die
	fi
}
