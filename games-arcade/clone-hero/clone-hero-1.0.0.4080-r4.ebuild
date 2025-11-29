# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
WX_GTK_VER="3.2-gtk3"
inherit desktop wrapper wxwidgets xdg

DESCRIPTION="Clone of Guitar Hero and similar games."
HOMEPAGE="https://clonehero.net/"
SRC_URI="https://pubdl.clonehero.net/clonehero-v${PV}-final/clonehero-linux.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/clonehero-linux"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="dev-libs/glib
	media-libs/alsa-lib
	media-libs/libglvnd
	virtual/zlib
	virtual/udev
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}"

src_install() {
	find . -name '*.so*' -exec chmod 0755 {} \; || die
	find . -name '*.dll' -exec chmod 0644 {} \; || die
	einstalldocs
	mkdir -p "${D}/opt/clonehero" || die
	cp -R ./* "${D}/opt/clonehero/" || die
	fperms 0755 /opt/clonehero/clonehero
	for size in 128 64 48 32 16; do
		newicon -s "${size}" "${FILESDIR}/${PN}-icon-${size}.png" "${PN}.png"
	done
	make_wrapper clonehero ./clonehero /opt/clonehero
	make_desktop_entry clonehero 'Clone Hero' "${PN}"
}
