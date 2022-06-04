# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit ecm

DESCRIPTION="Time tracking with WakaTime for Kate."
HOMEPAGE="https://github.com/tatsh/kate-wakatime"
SRC_URI="https://github.com/Tatsh/kate-wakatime/archive/v${PV}.tar.gz -> ${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="aqua debug"

DEPEND=">=kde-frameworks/ktexteditor-${KFMIN}:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"
