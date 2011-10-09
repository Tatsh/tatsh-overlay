# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit kde4-base git-2

DESCRIPTION="A KIO slave for KDE for managing iPhone/iPad file systems."
HOMEPAGE="https://github.com/JonathanBeck/kio_afc"
EGIT_REPO_URI="https://github.com/JonathanBeck/kio_afc.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
	$(add_kdebase_dep konqueror)
	$(add_kdebase_dep dolphin)
	app-pda/libimobiledevice
)"

src_install() {
	cmake-utils_src_install
}
