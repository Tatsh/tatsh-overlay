# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{2,3,4} )

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
IUSE="asm guard-pattern +vspipe +vsscript"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	vspipe? ( vsscript )
	asm? ( || ( amd64 x86 ) )"

DEPEND=">=media-libs/zimg-3.0.5
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
		$(meson_use vsscript enable_vsscript)
		$(meson_use vspipe enable_vspipe)
		-Denable_python_module=true
		-Dbuild_wheel=false
	)
	if use amd64 || use x86; then
		emesonargs+=( "$(meson_use asm enable_x86_asm)" )
	else
		emesonargs+=( -Denable_x86_asm=false )
	fi
	meson_src_configure
}
