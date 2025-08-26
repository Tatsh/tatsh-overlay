# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Xbox 360 emulator research project (Canary version)."
HOMEPAGE="https://github.com/xenia-canary/xenia-canary https://xenia.jp/"
SHA="765073021a3fd0ec193f89ff224aad5a3af31551"
SRC_URI="https://github.com/xenia-canary/xenia-canary/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"

LICENSE="MIT"
SLOT="0"
# KEYWORDS="~amd64"

DEPEND="app-arch/snappy
	app-arch/zarchive
	app-arch/zstd
	dev-cpp/catch:0
	dev-cpp/tomlplusplus
	dev-libs/capstone
	dev-libs/cxxopts
	dev-libs/date
	dev-libs/disruptorplus
	dev-libs/libfmt:=
	dev-libs/pugixml
	dev-libs/rapidcsv
	dev-libs/rapidjson
	dev-libs/tabulate
	dev-libs/utfcpp
	media-libs/VulkanMemoryAllocator
	dev-libs/xbyak
	dev-libs/xxhash
	dev-util/DirectXShaderCompiler
	dev-util/vulkan-headers
	media-libs/libsdl2
	media-video/ffmpeg:=
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""
