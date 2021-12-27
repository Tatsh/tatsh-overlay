# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_SINGLE_IMPL=true
inherit distutils-r1

DESCRIPTION="Joystick-aware screen waker."
HOMEPAGE="https://github.com/foresto/joystickwake"
SRC_URI="https://github.com/foresto/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
IUSE="X"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	$(python_gen_cond_dep 'dev-python/pyudev[${PYTHON_USEDEP}]')
	X? ( $(python_gen_cond_dep 'dev-python/python-xlib[${PYTHON_USEDEP}]') )"
