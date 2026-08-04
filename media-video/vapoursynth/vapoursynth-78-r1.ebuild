# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{2,3,4,5} )

inherit meson python-r1

DESCRIPTION="A video processing framework with simplicity in mind."
HOMEPAGE="https://www.vapoursynth.com/ https://github.com/vapoursynth/vapoursynth"
MY_PV="R${PV//_/-}"
MY_PV="${MY_PV^^}"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
# As of R78 upstream always builds vspipe, libvsscript and the Python module;
# the options that used to gate them no longer exist.
IUSE="asm guard-pattern"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	asm? ( || ( amd64 arm64 x86 ) )"

# R78 uses the chromatic_adaptation graph builder parameter, which is newer
# than any zimg release.
DEPEND=">=media-libs/zimg-3.0.6_p20260721
	${PYTHON_DEPS}
	virtual/zlib"
RDEPEND="${DEPEND}"
# shellcheck disable=SC2016
BDEPEND="${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/cython[${PYTHON_USEDEP}]')"

python_check_deps() {
	python_has_version "dev-python/cython[${PYTHON_USEDEP}]"
}

src_configure() {
	# shellcheck disable=SC2207
	local emesonargs=(
		$(meson_use guard-pattern enable_guard_pattern)
	)
	if use amd64 || use x86; then
		emesonargs+=( "$(meson_use asm enable_x86_asm)" )
	else
		emesonargs+=( -Denable_x86_asm=false )
	fi
	if use arm64; then
		emesonargs+=( "$(meson_use asm enable_arm_asm)" )
	else
		emesonargs+=( -Denable_arm_asm=false )
	fi
	meson_src_configure
}

src_install() {
	meson_src_install

	# R78 keeps the C headers and the pkgconfig file inside the Python package,
	# where nothing but vapoursynth.get_include() looks for them. Install them
	# where every other consumer expects to find them as well.
	insinto "/usr/include/${PN}"
	doins include/*.h

	cat > "${T}/${PN}.pc" <<-PC || die
		prefix=${EPREFIX}/usr
		includedir=\${prefix}/include/${PN}

		Name: ${PN}
		Description: A frameserver for the 21st century
		Version: ${PV}
		Cflags: -I\${includedir}
	PC
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${T}/${PN}.pc"
}
