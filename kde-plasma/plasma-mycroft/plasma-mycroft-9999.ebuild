# Copyright 1999-2018 Gentoo Foundation
# Distribituted under the terms of the GNU General Public License v2

EAPI=6
KDE_AUTODEPS="false"
inherit kde5 git-r3

DESCRIPTION="Mycroft AI plasmoid and skills."
HOMEPAGE="https://cgit.kde.org/plasma-mycroft.git/"

LICENSE="Apache-2.0 GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig "" 5.46.0)
	$(add_frameworks_dep kcoreaddons "" 5.46.0)
	$(add_frameworks_dep plasma "" 5.46.0)
	$(add_frameworks_dep knotifications "" 5.46.0)
	$(add_frameworks_dep kpackage "" 5.46.0)
	$(add_frameworks_dep ki18n "" 5.46.0)
	$(add_frameworks_dep kservice "" 5.46.0)
	$(add_frameworks_dep extra-cmake-modules "" 5.46.0)
	|| ( $(add_frameworks_dep breeze-icons "" 5.46.0)
		kde-frameworks/oxygen-icons:* )
	$(add_qt_dep qtcore)"
RDEPEND="${DEPEND}
	>=kde-frameworks/kf-env-4
	$(add_qt_dep qtwebsockets)"
