# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Improved Jinja2 syntax highlighting for Kate."
HOMEPAGE="https://github.com/Pitmairen/kate-jinja2-highlighting"
MY_HASH="b0e25e00af4927030594b5813aaf90d728c6d442"
SRC_URI="https://github.com/Pitmairen/${PN}/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

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
