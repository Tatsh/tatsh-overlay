# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="RIFE filter for VapourSynth."
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan/archive/refs/tags/r9.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn media-libs/vulkan-loader"
RDEPEND="${DEPEND}"

S="${WORKDIR}/VapourSynth-RIFE-ncnn-Vulkan-r${PV}"

src_configure() {
	local emesonargs=( -Duse_system_ncnn=true )
	meson_src_configure
}
