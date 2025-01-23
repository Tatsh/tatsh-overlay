# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tool for performing reflection on SPIR-V."
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Cross"
SHA="1a7b7ef6de02cf6767e42b10ddad217c45e90d47"
SRC_URI="https://github.com/KhronosGroup/SPIRV-Cross/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/SPIRV-Cross-${SHA}"
