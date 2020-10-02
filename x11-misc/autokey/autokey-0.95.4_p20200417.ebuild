# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="A desktop automation utility for Linux and X11."
HOMEPAGE="https://github.com/autokey/autokey"
MY_SHA="381876ae2ab2fd6fdb8593eb5920074781bdd95f"
SRC_URI="https://github.com/autokey/autokey/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +qt"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	|| ( gtk qt )"

RDEPEND="${PYTHON_DEPS}
	dev-python/pyinotify
	dev-python/python-xlib
	dev-python/dbus-python
	x11-misc/wmctrl
	qt? (
		dev-python/PyQt5[svg]
		dev-python/qscintilla-python
		kde-apps/kdialog
	)
	gtk? (
		dev-python/pygobject:3
		x11-libs/wxGTK:3.0
		dev-libs/libappindicator
		dev-libs/dbus-glib
		gnome-extra/zenity
		x11-libs/gtksourceview:3
	)"
BDEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/qt-focus-169.patch" )

S="${WORKDIR}/${PN}-${MY_SHA}"

src_install() {
	distutils-r1_src_install
	if ! use qt; then
		rm "${D}/usr/bin/${PN}-qt" "${D}/usr/share/applications/${PN}-qt.desktop" \
			"${D}/usr/share/man/man"*/${PN}-qt.* \
			"${D}/usr/lib/python-exec/"*/${PN}-gtk
	fi
	if ! use gtk; then
		rm "${D}/usr/bin/${PN}-gtk" "${D}/usr/share/applications/${PN}-gtk.desktop" \
			"${D}/usr/share/man/man"*/${PN}-gtk.* \
			"${D}/usr/lib/python-exec/"*/${PN}-gtk
	fi
}
