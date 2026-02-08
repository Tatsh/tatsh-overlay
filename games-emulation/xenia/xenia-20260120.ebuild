# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Xbox 360 emulator research project."
HOMEPAGE="https://github.com/xenia-project/xenia https://xenia.jp/"
SHA="c7f61342d7061b8264e4b988b8d2e03351b6e088"
SRC_URI="https://github.com/xenia-project/xenia/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/xenia-${SHA}"

LICENSE="MIT"
SLOT="0"
# KEYWORDS="~amd64"

DEPEND="app-arch/snappy
	dev-cpp/catch:0
	dev-libs/capstone
	dev-libs/cxxopts
	dev-libs/date
	dev-libs/disruptorplus
	dev-libs/libfmt:=
	dev-libs/rapidjson
	dev-libs/utfcpp
	dev-libs/xbyak
	dev-libs/xxhash
	dev-util/DirectXShaderCompiler
	dev-util/vulkan-headers
	media-libs/VulkanMemoryAllocator
	media-libs/libsdl2
	media-video/ffmpeg:=
	virtual/zlib"
RDEPEND="${DEPEND}"
