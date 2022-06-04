# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Improved Jinja2 syntax highlighting for Kate."
HOMEPAGE="https://github.com/Pitmairen/kate-jinja2-highlighting"
SHA="8ab9b0d40c54425d6a6b3e5f5ca9bf9f163389d9"
SRC_URI="https://github.com/Pitmairen/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	insinto /usr/share/org.kde.syntax-highlighting/syntax
	doins *.xml
	einstalldocs
}
