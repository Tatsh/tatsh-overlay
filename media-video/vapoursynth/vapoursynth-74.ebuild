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
KEYWORDS="~amd64 ~x86"
IUSE="guard-pattern +x86-asm +vspipe +vsscript"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	vspipe? ( vsscript )"

DEPEND=">=media-libs/zimg-3.0.5
	${PYTHON_DEPS}
	virtual/zlib"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/cython[${PYTHON_USEDEP}]')"

python_check_deps() {
	python_has_version "dev-python/cython[${PYTHON_USEDEP}]"
}

src_configure() {
	local emesonargs=(
		$(meson_use guard-pattern enable_guard_pattern)
		$(meson_use x86-asm enable_x86_asm)
		$(meson_use vsscript enable_vsscript)
		$(meson_use vspipe enable_vspipe)
		-Denable_python_module=true
		-Dbuild_wheel=false
	)
	meson_src_configure
}
