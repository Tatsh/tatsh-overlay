# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson udev

DESCRIPTION="Library to add support for consumer fingerprint readers"
HOMEPAGE="https://gitlab.freedesktop.org/libfprint/libfprint"
SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples gtk-doc +introspection test"
RESTRICT="!test? ( test )"

RDEPEND="virtual/libusb:1=
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXv"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	dev-libs/libgusb
	dev-libs/libgudev
	dev-libs/nss
	x11-libs/pixman
	test? ( x11-libs/cairo )"
BDEPEND="virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )"

PATCHES=( "${FILESDIR}/${PN}-0.8.2-fix-implicit-declaration.patch" )

src_configure() {
		local emesonargs=(
			"$(meson_use examples gtk-examples)"
			"$(meson_use introspection)"
			"$(meson_use gtk-doc doc)"
			-Ddrivers=all
			-Dudev_rules=enabled
			"-Dudev_rules_dir=$(get_udevdir)/rules.d"
			"--libdir=/usr/$(get_libdir)"
		)
		meson_src_configure
}
