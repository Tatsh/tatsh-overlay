# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-base

DESCRIPTION="Time tracking with WakaTime for Kate."
HOMEPAGE="https://github.com/tatsh/kate-wakatime"
SRC_URI="https://github.com/Tatsh/kate-wakatime/archive/v${PV}.tar.gz -> ${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND=">=dev-libs/qjson-0.8.1"
RDEPEND="
        $(add_kdebase_dep kate)
"
