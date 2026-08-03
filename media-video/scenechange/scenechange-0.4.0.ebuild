# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit cmake python-r1

DESCRIPTION="Scene change detection plugin for VapourSynth"
HOMEPAGE="
	https://tatsh.github.io/scenechange/
	https://github.com/Tatsh/scenechange
"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	media-video/vapoursynth
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		# Compile against the VapourSynth headers from the dependency rather
		# than downloading VapourSynth4.h at configure time.
		-DSCENECHANGE_FETCH_VAPOURSYNTH_HEADERS=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# shellcheck disable=SC2329
	install_py_module() {
		# shellcheck disable=SC2317
		python_domodule "${S}/${PN}"
	}
	python_foreach_impl install_py_module
}
