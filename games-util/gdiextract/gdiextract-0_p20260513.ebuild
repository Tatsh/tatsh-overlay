# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tool to extract files from Sega Dreamcast GD-ROM dumps in .gdi format."
HOMEPAGE="https://github.com/MachXNU/gdiextract"
SHA="da98843213a8dbe295ccf111d11d16173376b690"
SRC_URI="https://github.com/MachXNU/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/argparse"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		# Use the system argparse; the fallback fetches it from GitHub at build time.
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
	)
	cmake_src_configure
}
