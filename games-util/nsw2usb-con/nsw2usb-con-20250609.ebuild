# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )

inherit python-r1 udev

DESCRIPTION="Enable Switch 2-Pro-Controller and NSO GameCube controller input via USB."
HOMEPAGE="https://github.com/djedditt/nsw2usb-con"
SHA="6768e0566cbbbb4666a3ebed3e9abcd2fef0f131"
SRC_URI="https://github.com/djedditt/nsw2usb-con/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	dev-python/pyusb[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-ignore-set-conf-fail.patch"
	"${FILESDIR}/${PN}-other.patch"
)
DOCS=( README.md )

src_install() {
	python_foreach_impl python_doscript "${PN}.py"
	udev_dorules "${FILESDIR}/95-${PN}.rules"
	einstalldocs
}
