# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Easy to integrate Vulkan memory allocation library"
HOMEPAGE="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator"
SHA="871913da6a4b132b567d7b65c509600363c0041e"
SRC_URI="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/vulkan-loader"
RDEPEND="${DEPEND}"

S="${WORKDIR}/VulkanMemoryAllocator-${SHA}"
