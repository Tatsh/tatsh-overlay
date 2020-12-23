# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""
MY_SHA="b61255e76736ef6241d3be28ffaccefd9e057850"
SRC_URI="https://github.com/Tatsh/open-in-mpv/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

src_install() {
	dobin host/open-in-mpv
	einstalldocs
}
