# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )

inherit python-single-r1 udev

DESCRIPTION="Enable Switch 2 Pro Controller and NSO GameCube controller input via USB."
HOMEPAGE="https://github.com/ikz87/NSW2-controller-enabler"
MY_PN="NSW2-controller-enabler"
SHA="cb8946f34f7befab35860ce9f45155cf3edc68ff"
SRC_URI="https://github.com/ikz87/${MY_PN}/archive/${SHA}.tar.gz
	-> ${P}-${SHA:0:8}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${SHA}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# hid comes from dev-python/hidapi, uinput from dev-python/python-uinput.
# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/hidapi[${PYTHON_USEDEP}]
		dev-python/pyusb[${PYTHON_USEDEP}]
		dev-python/python-uinput[${PYTHON_USEDEP}]
	')"
BDEPEND="${RDEPEND}"

DOCS=( README.md )

src_install() {
	python_newscript enable_hid.py "${PN}"
	udev_dorules "${FILESDIR}/95-${PN}.rules"
	einstalldocs
}

pkg_postinst() {
	udev_reload
	elog
	elog "Your user must be in the 'input' group to use the controller."
	elog
	elog "The controller is switched into HID mode automatically on connect."
	elog "It can also be done by hand with:"
	elog
	elog "  ${PN}"
	elog
}

pkg_postrm() {
	udev_reload
}
