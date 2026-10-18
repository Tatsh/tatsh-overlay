# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ps2-port

DESCRIPTION="Graphics Synthesizer library for the PlayStation 2"
HOMEPAGE="https://github.com/ps2dev/gsKit"
SRC_URI="https://github.com/ps2dev/gsKit/archive/refs/tags/v${PV}.tar.gz -> gsKit-${PV}.tar.gz"
S="${WORKDIR}/gsKit-${PV}"

LICENSE="AFL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-games/ps2-libjpeg-turbo
	dev-games/ps2-libpng
	dev-games/ps2-libtiff
"
RDEPEND="${DEPEND}"

src_prepare() {
	# The version otherwise comes from git describe. Fix gsKit.pc: the CMake list of requirements
	# would be written with semicolons, which pkg-config cannot parse, and gskit_toolkit must precede
	# gskit when linking statically.
	# shellcheck disable=SC2016
	sed -i \
		-e "s/^set(CUR_GIT_TAG v0.0.0)/set(CUR_GIT_TAG v${PV})/" \
		-e 's/^set(PCKEY_REQUIRES "${GSKIT_EXTERNAL_REQUIRES}")/list(JOIN GSKIT_EXTERNAL_REQUIRES " " PCKEY_REQUIRES)/' \
		-e 's/^set(PCKEY_LIBS "-lgskit -ldmakit -lgskit_toolkit")/set(PCKEY_LIBS "-lgskit_toolkit -lgskit -ldmakit")/' \
		CMakeLists.txt || die
	default
}

src_configure() {
	local -x GSKIT="${EPREFIX}${PS2_PORTS}"
	local mycmakeargs=(
		-DBUILD_EXAMPLES=
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
	)
	ps2-port_src_configure
}

src_install() {
	ps2-port_src_install
	newenvd - 50gskit <<-EOF2
		GSKIT="${EPREFIX}${PS2_PORTS}"
	EOF2
}
