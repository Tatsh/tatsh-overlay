# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Improved Jinja2 syntax highlighting for Kate."
HOMEPAGE="https://github.com/Pitmairen/kate-jinja2-highlighting"
MY_HASH="8ab9b0d40c54425d6a6b3e5f5ca9bf9f163389d9"
SRC_URI="https://github.com/Pitmairen/${PN}/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_HASH}"

DOCS=( README.rst )

src_install() {
	insinto /usr/share/org.kde.syntax-highlighting/syntax
	doins *.xml
	einstalldocs
}
