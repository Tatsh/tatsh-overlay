# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tool for performing reflection on SPIR-V."
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Cross"
SHA="6173e24b31f09a0c3217103a130e74c4ddec14a6"
SRC_URI="https://github.com/KhronosGroup/SPIRV-Cross/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/SPIRV-Cross-${SHA}"
