# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Library to interface with a locally running Discord desktop client."
HOMEPAGE="https://github.com/discordapp/discord-rpc"
SRC_URI="https://github.com/discordapp/discord-rpc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-libs/rapidjson"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( LICENSE README.md )

src_configure() {
	mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
	)
	cmake_src_configure
}
