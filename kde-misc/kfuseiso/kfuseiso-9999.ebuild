# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Desktop entry file to easily mount disc images."
HOMEPAGE="https://github.com/tatsh/kfuseiso"
EGIT_REPO_URI="git://github.com/tatsh/kfuseiso.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# TODO Find correct list of dependencies
DEPEND="kde-base/dolphin
kde-base/kdialog
sys-fs/fuseiso"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/kde4/services/ServiceMenus
	doins kfuseiso_mount.desktop

	exeinto /usr/share/kfuseiso
	doexe mountiso.sh umountiso.sh
}
