# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit python-single-r1

DESCRIPTION="Firmware update utility for the RetroTINK family of retro gaming devices."
HOMEPAGE="https://github.com/rmull/tinkup"
SHA="c1cf6d265ef6ae2c3bae7696739c52f9279afd27"
SRC_URI="https://github.com/rmull/tinkup/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS} $(python_gen_cond_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	python_newscript "${PN}.py" "${PN}"
	einstalldocs
}
