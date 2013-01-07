# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2
DESCRIPTION="The Clearlooks-Phenix project (formerly known as Clearwaita) aims at creating a GTK3 port of Clearlooks, the default theme for Gnome 2."
HOMEPAGE="http://www.jpfleury.net/en/software/clearlooks-phenix.php"
SRC_URI="http://jpfleury.indefero.net/p/clearlooks-phenix/source/download/${PV} -> ${P}.zip"

KEYWORDS="amd64 x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
 x11-themes/gtk-engines
 x11-themes/gnome-themes-standard
 x11-themes/gtk-engines-unico
"
DEPEND="${RDEPEND}"

src_install() {
 cd "${WORKDIR}"
 insinto "/usr/share/themes/Clearlooks-Phenix"
 doins -r ${P}/* || die
}
