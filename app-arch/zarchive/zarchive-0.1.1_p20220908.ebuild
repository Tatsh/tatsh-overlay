# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for creating and reading zstd-compressed file archives (.zar)"
HOMEPAGE="https://github.com/Exzap/ZArchive"
SHA="d2c717730092c7bf8cbb033b12fd4001b7c4d932"
MY_PN="ZArchive"
SRC_URI="https://github.com/Exzap/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/zstd"

S="${WORKDIR}/${MY_PN}-${SHA}"
