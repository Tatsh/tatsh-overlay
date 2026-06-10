# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1

DESCRIPTION="Joystick-aware screen waker."
HOMEPAGE="https://codeberg.org/forestix/joystickwake"
SRC_URI="https://codeberg.org/forestix/joystickwake/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep 'dev-python/pyudev[${PYTHON_USEDEP}]')"

S="${WORKDIR}/${PN}"
