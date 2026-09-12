# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )

inherit python-single-r1

DESCRIPTION="Muonium's collection of VapourSynth functions."
HOMEPAGE="https://github.com/WolframRhodium/muvsfunc"
SRC_URI="https://github.com/WolframRhodium/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	media-video/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"

src_install() {
	# Only these are meant to be imported. The rest of Collections/ are
	# standalone scripts with generic names such as resize.py, which would
	# shadow unrelated modules if installed into site-packages.
	python_domodule muvsfunc.py muvs.py \
		Collections/muvsfunc_misc.py Collections/muvsfunc_numpy.py

	einstalldocs
	docinto collections
	dodoc Collections/LUM.py Collections/net_interp.py \
		Collections/resize.py Collections/SuperRes.py \
		Collections/descale_verifyer.vpy
	docinto collections/examples
	dodoc -r Collections/examples/.
}

pkg_postinst() {
	elog "Individual functions require additional VapourSynth plugins, which"
	elog "are not pulled in as dependencies. See the docstrings in muvsfunc.py"
	elog "for what each function needs."
}

pkg_setup() {
	python-single-r1_pkg_setup
}
