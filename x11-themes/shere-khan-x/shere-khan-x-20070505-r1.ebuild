# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The dreaded beachball."
HOMEPAGE="https://store.kde.org/p/999971/"
SRC_URI="https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE0NjA3MzUzNjEiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImJlODgyNjE5M2Q0MWU4YjkxM2Q3NGEwNDEzYmU4MjlkODBjMGU2NzM1YjBkMTBlZDRhYWY2MDZhNjAzMWY1YTY5NDFjYjczZjFlNGUzZGFjYTUyMTQxM2I3ZjdmMWZmN2M5MjRkODc1MDgyZWUzY2U1NTBhMWI0ODAwNjJiYjg1IiwidCI6MTYwODY1NzE1MCwic3RmcCI6IjEwNmI2YWNkN2ZkNDZlZjQ1N2M0NTI2NTdjY2E5NGY4Iiwic3RpcCI6IjI2MDI6NDM6ZWJkMDo4ZDAyOmQ1ODA6YTUwMzphNGI6ZWQ5OSJ9.9pTSZ0RyvkBmPXWkThTTtCD6yUnZevZV5bnFzYeQHvU/57588-Shere_Khan_X.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/Shere_Khan_X"

src_install() {
	insinto /usr/share/icons/Shere_Khan_X/cursors/
	doins cursors/*
}
