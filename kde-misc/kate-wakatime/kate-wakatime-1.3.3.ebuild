# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

KDE_TEST="false"
inherit kde5

DESCRIPTION="Time tracking with WakaTime for Kate."
HOMEPAGE="https://github.com/tatsh/kate-wakatime"
SRC_URI="https://github.com/Tatsh/kate-wakatime/archive/v${PV}.tar.gz -> ${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~x86 ~amd64"
IUSE="aqua debug"

DEPEND="$(add_frameworks_dep ktexteditor)"
RDEPEND="${DEPEND}"
