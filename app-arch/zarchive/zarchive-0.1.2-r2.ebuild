# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for creating and reading zstd-compressed file archives (.zar)"
HOMEPAGE="https://github.com/Exzap/ZArchive"
SHA="965b66c8d67b6b7e30fd63b3b75aa91a99ff303b"
MY_PN="ZArchive"
SRC_URI="https://github.com/Exzap/${MY_PN}/archive/${SHA}.tar.gz
	-> ${P}-${SHA:0:8}.gh.tar.gz"

S="${WORKDIR}/${MY_PN}-${SHA}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/zstd:="
