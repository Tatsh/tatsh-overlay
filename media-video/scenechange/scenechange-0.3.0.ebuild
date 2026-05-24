# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

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

src_prepare() {
	cmake_src_prepare
	# Drop temporalsoften2.py from the CMake doc install; we install the
	# wrapper into every enabled Python implementation's site-packages below.
	sed -i '\|temporalsoften2\.py|d' src/CMakeLists.txt || die
}

src_install() {
	cmake_src_install
	install_py_module() {
		python_domodule "${S}/temporalsoften2.py"
	}
	python_foreach_impl install_py_module
}
