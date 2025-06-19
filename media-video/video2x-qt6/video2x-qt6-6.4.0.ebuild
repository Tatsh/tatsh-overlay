# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt 6 GUI for Video2x."
HOMEPAGE="https://github.com/k4yt3x/video2x-qt6"
SRC_URI="https://github.com/k4yt3x/video2x-qt6/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6
	dev-qt/qtsvg:6
	dev-libs/libfmt
	dev-libs/spdlog
	media-libs/vulkan-loader
	media-video/ffmpeg"
RDEPEND="${DEPEND}
	>=media-video/video2x-${PV}"

src_configure() {
	local mycmakeargs=(
		-DUSE_EXTERNAL_SPDLOG=ON
		-DUSE_EXTERNAL_VIDEO2X=ON
	)
	cmake_src_configure
}
