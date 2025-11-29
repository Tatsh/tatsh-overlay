# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit desktop distutils-r1 systemd udev xdg

DESCRIPTION="An easy to use tool to change the behaviour of your input devices."
HOMEPAGE="https://github.com/sezanzeb/input-remapper"
SRC_URI="https://github.com/sezanzeb/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pydbus[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/evdev[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	x11-libs/gtksourceview:4"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-no-data-files.patch" )

distutils_enable_tests unittest

src_install() {
	distutils-r1_src_install
	domenu "data/${PN}-gtk.desktop"
	insinto /usr/share/metainfo
	doins "data/io.github.sezanzeb.${PN/-/_}.metainfo.xml"
	insinto /usr/share/polkit-1/actions
	doins "data/${PN}.policy"
	systemd_dounit "data/${PN}.service"
	insinto /usr/share/dbus-1/system.d
	doins data/inputremapper.Control.conf
	insinto /etc/xdg/autostart
	doins "data/${PN}-autoload.desktop"
	udev_dorules "data/99-${PN}.rules"
	dobin "bin/${PN}-"*
	insinto "/usr/share/${PN}"
	doins "data/${PN}-large.png" "data/${PN}.glade" "data/${PN}.svg" data/style.css
}
