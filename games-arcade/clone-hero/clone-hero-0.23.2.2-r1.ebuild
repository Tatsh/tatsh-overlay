# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
WX_GTK_VER="3.0-gtk3"
inherit desktop wxwidgets xdg

DESCRIPTION="Clone of Guitar Hero and similar games."
HOMEPAGE="https://clonehero.net/"
SRC_URI="http://dl.clonehero.net/clonehero-v${PV:1}/clonehero-linux.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="sys-libs/zlib
	x11-libs/wxGTK:3.0-gtk3
	dev-libs/glib
	x11-libs/gdk-pixbuf
	x11-libs/gtk+"
DEPEND="${RDEPEND}"

S="${WORKDIR}/clonehero-linux"

src_install() {
	find . -name '*.so*' -exec chmod 0755 {} \; || die
	find . -name '*.dll' -exec chmod 0644 {} \; || die
	einstalldocs
	rm README.txt || die
	mkdir -p "${D}/opt/clonehero" || die
	cp -R ./* "${D}/opt/clonehero/" || die
	keepdir /opt/clonehero/{Screenshots,Songs}
	insinto /opt/clonehero
	doins "${FILESDIR}/settings.ini"
	doenvd "${FILESDIR}/99${PN}"
	exeinto /opt/bin
	doexe "${FILESDIR}/clonehero"
	fperms 0755 /opt/clonehero/clonehero
	fperms 0777 /opt/clonehero/{Custom,Screenshots,Songs}
	for size in 128 64 48 32 16; do
		newicon -s "${size}" "${FILESDIR}/${PN}-icon-${size}.png" "${PN}.png"
	done
	make_desktop_entry clonehero 'Clone Hero' "${PN}"
}

pkg_postinst() {
	elog "You may need to give settings.ini world-writable permissions:"
	elog "chmod 0666 /opt/clonehero/settings.ini"
}
