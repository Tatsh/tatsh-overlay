# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Improved Jinja2 syntax highlighting for Kate."
HOMEPAGE="https://github.com/Pitmairen/kate-jinja2-highlighting"
SHA="df606468593f340207749eb7f7048c4c854d174a"
SRC_URI="https://github.com/Pitmairen/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

src_install() {
	insinto /usr/share/org.kde.syntax-highlighting/syntax
	doins ./*.xml
	einstalldocs
}
