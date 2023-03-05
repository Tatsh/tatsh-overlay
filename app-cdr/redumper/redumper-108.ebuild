# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Low level CD dumper utility"
HOMEPAGE="https://github.com/superg/redumper"
SRC_URI="https://github.com/superg/redumper/archive/refs/tags/build_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-libs/libfmt"

PATCHES=(
	"${FILESDIR}/${PN}-0001-add-bd-re-wh16ns60-1.02.patch"
	"${FILESDIR}/${PN}-0002-system-fmt.patch"
)

S="${WORKDIR}/${PN}-build_${PV}"

src_prepare() {
	rm -fR fmt || die
	cmake_src_prepare
}
