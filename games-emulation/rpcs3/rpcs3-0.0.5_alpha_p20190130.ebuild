# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="PS3 emulator and debugger."
HOMEPAGE="https://rpcs3.net/"
MY_HASH="039f8e1f9d6afe8df6ff47af894e07e702c38fc1"
LLVM_HASH="5c906fd1694e3c8f0b9548581d275ef01dc0972a"
SRC_URI="https://github.com/RPCS3/rpcs3/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz
	https://github.com/RPCS3/llvm/archive/${LLVM_HASH}.tar.gz -> ${P}-llvm.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa pulseaudio evdev vulkan +dbus wayland"

REQUIRED_USE="wayland? ( vulkan )"

DEPEND="virtual/jpeg:=
	media-libs/libpng:=
	pulseaudio? ( media-sound/pulseaudio )
	evdev? ( dev-libs/libevdev )
	vulkan? ( dev-util/vulkan-headers )
	media-libs/openal
	virtual/opengl
	dev-cpp/ms-gsl
	dev-util/glslang
	sys-libs/zlib
	dev-cpp/yaml-cpp
	dev-libs/xxhash
	dev-libs/hidapi
	virtual/ffmpeg
	dev-libs/cereal
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtcore:5
	dbus? ( dev-qt/qtdbus )
	dev-qt/qtgui
	wayland? ( dev-libs/wayland )"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_HASH}"
PATCHES=(
	"${FILESDIR}/system-libs.patch"
	"${FILESDIR}/use-wayland.patch"
	"${FILESDIR}/out-of-source-build.patch"
)

CMAKE_BUILD_TYPE=RelWithDebInfo

src_prepare() {
	if ! use dbus; then sed -e '10,+2d' -i 3rdparty/qt5.cmake || die; fi
	rmdir "${S}/llvm" || die
	mv "${WORKDIR}/llvm-${LLVM_HASH}" "${S}/llvm" || die
	echo '#define RPCS3_GIT_VERSION "7764-039f8e1f"' > rpcs3/git-version.h
	echo '#define RPCS3_GIT_BRANCH "master"' >> rpcs3/git-version.h
	echo '#define RPCS3_GIT_VERSION_NO_UPDATE 1' >> rpcs3/git-version.h
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DUSE_ALSA=$(usex alsa)
		-DUSE_PULSE=$(usex pulseaudio)
		-DUSE_LIBEVDEV=$(usex evdev)
		-DUSE_VULKAN=$(usex vulkan)
		-DUSE_SYSTEM_ZLIB=yes
		-DUSE_SYSTEM_LIBPNG=yes
		-DUSE_SYSTEM_FFMPEG=yes
		-DWITH_LLVM=yes
		-DBUILD_LLVM_SUBMODULE=yes
		-DUSE_SYSTEM_PUGIXML=yes
		-DUSE_SYSTEM_HIDAPI=yes
		-DUSE_SYSTEM_YAMLCPP=yes
		# FIXME Discord RPC is packaged as static libs
		# Should be built https://github.com/discordapp/discord-rpc
		-DUSE_DISCORD_RPC=OFF
		-DUSE_SYSTEM_GLSLANG=yes
		-DUSE_SYSTEM_ASMJIT=yes
		-DUSE_SYSTEM_XXHASH=yes
		-DBUILD_SHARED_LIBS=no
	)
	if use wayland; then
		mycmakeargs+=( -DUSE_WAYLAND=yes )
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	mv "${D}/usr/bin/rpcs3" "${D}/usr/bin/rpcs3.bin"
	cat > rpcs3.sh <<EOF
#!/bin/sh
export XDG_CURRENT_DESKTOP=qt
/usr/bin/rpcs3.bin "\$@"
EOF
	newbin rpcs3.sh rpcs3
	einstalldocs
}
