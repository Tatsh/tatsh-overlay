# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

# Upstream builds one stable-ABI module (vapoursynth.abi3.so), so there is
# nothing to repeat per implementation.
inherit meson python-single-r1

DESCRIPTION="A video processing framework with simplicity in mind"
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
IUSE="asm guard-pattern test"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	asm? ( || ( amd64 arm64 x86 ) )"

# R78 uses the chromatic_adaptation graph builder parameter, which is newer
# than any zimg release.
DEPEND=">=media-libs/zimg-3.0.6_p20260721
	${PYTHON_DEPS}
	dev-util/glslang:=
	virtual/zlib"
RDEPEND="${DEPEND}"
# shellcheck disable=SC2016
BDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/cython[${PYTHON_USEDEP}]
		test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	')"

PATCHES=( "${FILESDIR}/${PN}-system-glslang.patch" )

pkg_setup() {
	python-single-r1_pkg_setup
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

src_test() {
	# The tests import the Python module, which loads libvapoursynth from the
	# library directory, so run them against a staged install.
	local root="${T}/test-root"
	DESTDIR="${root}" meson install -C "${BUILD_DIR}" --no-rebuild --quiet || die
	local -x PYTHONPATH LD_LIBRARY_PATH
	PYTHONPATH="${root}$(python_get_sitedir)" || die
	LD_LIBRARY_PATH="${root}/usr/$(get_libdir)" || die
	# The GPU resize tests skip without a usable Vulkan device.
	local dev
	for dev in /dev/dri /dev/nvidia*; do
		[[ -e ${dev} ]] && addwrite "${dev}"
	done
	# The NVIDIA driver also (re)creates /dev/char links and writes per-thread state.
	addpredict /dev/char
	addwrite /proc/self/task
	epytest test
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
