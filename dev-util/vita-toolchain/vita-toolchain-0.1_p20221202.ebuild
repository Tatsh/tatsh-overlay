# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="PS Vita toolchain."
HOMEPAGE="https://github.com/vitasdk/vita-toolchain"
SHA="c938f0ffd94a8d10887a222849287a59ff1e1da9"
SRC_URI="https://github.com/vitasdk/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libyaml
	dev-libs/libzip
	sys-libs/zlib
	virtual/libelf"
RDEPEND="${DEPEND}
	dev-util/psp2rela"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -re 's/^pkg_check_modules\(PC_libelf.*/pkg_check_modules(PC_libelf REQUIRED)/' \
		-i cmake/Modules/Findlibelf.cmake || die
	cmake_src_prepare
}
