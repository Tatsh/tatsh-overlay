# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9,10,11} )
inherit python-single-r1

DESCRIPTION="Host-side script for the Open in mpv Chrome extension."
HOMEPAGE="https://github.com/Tatsh/open-in-mpv"
SRC_URI="https://github.com/Tatsh/open-in-mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="${PYTHON_DEPS}
	media-video/mpv"

src_prepare() {
	cp host/sh.tat.open_in_mpv.json.in sh.tat.open_in_mpv.json || die
	sed -re "s|@BIN_PATH@|${EPREFIX}/usr/bin|g" -i sh.tat.open_in_mpv.json || die
	default
}

src_install() {
	python_newscript "host/${PN}" "${PN}"
	insinto /etc/opt/chrome/native-messaging-hosts
	doins sh.tat.open_in_mpv.json
	einstalldocs
}
