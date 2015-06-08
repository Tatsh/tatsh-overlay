# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 kde4-base

DESCRIPTION="Desktop entry file to easily mount disc images."
HOMEPAGE="https://github.com/Tatsh/kfuseiso"
EGIT_REPO_URI="git://github.com/Tatsh/kfuseiso.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# TODO Find correct list of dependencies
DEPEND="$(add_kdeapps_dep dolphin)
$(add_kdeapps_dep kdialog)
sys-fs/fuseiso"
RDEPEND="${DEPEND}"

src_prepare() {
	einfo 'Skipping CMake ...'
}

src_configure() {
	einfo 'Skipping CMake ...'
}

src_compile() {
	einfo 'Skipping CMake ...'
}

src_install() {
	insinto /usr/share/kde4/services/ServiceMenus
	doins kfuseiso_mount.desktop

	exeinto /usr/share/kfuseiso
	doexe mountiso.sh umountiso.sh
}
