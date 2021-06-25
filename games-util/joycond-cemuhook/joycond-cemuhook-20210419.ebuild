# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit python-single-r1

DESCRIPTION="Support for cemuhook's UDP protocol for joycond devices."
HOMEPAGE="https://github.com/joaorb64/joycond-cemuhook"
SHA="fe346d2483ca3247e9329125cd126fa8790a4c56"
SRC_URI="https://github.com/joaorb64/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="games-util/joycond
	$(python_gen_cond_dep '
		dev-python/python-evdev[${PYTHON_USEDEP}]
		dev-python/pyudev[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/termcolor[${PYTHON_USEDEP}]')"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -r \
		-e "s:with open\(os.path.join\('profiles',:with open(os.path.join('${EPREFIX}/usr/share/${PN}/profiles',:" \
		-i "${PN}.py" || die
	echo '#!/usr/bin/env python' > out.py
	cat "${PN}.py" >> out.py || die
	python_fix_shebang -q out.py || die
	mv out.py "${PN}.py" || die
	default
}

src_install() {
	dobin "${PN}.py"
	insinto /usr/share/${PN}/profiles
	doins profiles/*.json
	einstalldocs
}
