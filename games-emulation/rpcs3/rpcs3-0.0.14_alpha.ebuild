# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="PS3 emulator and debugger."
HOMEPAGE="https://rpcs3.net/"
MY_SHA="v0.0.14"
ASMJIT_SHA="fc251c914e77cd079e58982cdab00a47539d7fc5"
LLVM_SHA="716bb292ba3b4e5c0ceff72fee911ed2b53232cf"
SRC_URI="https://github.com/RPCS3/rpcs3/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/RPCS3/llvm-mirror/archive/${LLVM_SHA}.tar.gz -> ${P}-llvm.tar.gz
	https://github.com/asmjit/asmjit/archive/${ASMJIT_SHA}.tar.gz -> ${P}-asmjit.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa pulseaudio evdev vulkan +dbus wayland"
REQUIRED_USE="wayland? ( vulkan )"

DEPEND="dev-cpp/ms-gsl
	dev-cpp/yaml-cpp
	dev-libs/cereal
	dev-libs/discord-rpc
	dev-libs/hidapi
	dev-libs/pugixml
	dev-libs/xxhash
	dev-qt/qtcore:5
	dev-qt/qtgui
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-util/glslang
	media-libs/libpng:=
	media-libs/openal
	media-video/ffmpeg
	sys-libs/zlib
	virtual/jpeg:=
	virtual/opengl
	dbus? ( dev-qt/qtdbus )
	evdev? ( dev-libs/libevdev )
	pulseaudio? ( media-sound/pulseaudio )
	vulkan? ( dev-util/vulkan-headers )
	wayland? ( dev-libs/wayland )"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA:1}"
PATCHES=(
	"${FILESDIR}/use-wayland.patch"
	"${FILESDIR}/system-libs.patch"
)

src_prepare() {
	if ! use dbus; then sed -e '10,+2d' -i 3rdparty/qt5.cmake || die; fi
	rmdir "${S}/llvm" || die
	mv "${WORKDIR}/llvm-mirror-${LLVM_SHA}" "${S}/llvm" || die
	rmdir "${S}/asmjit" || die
	mv "${WORKDIR}/asmjit-${ASMJIT_SHA}" "${S}/asmjit" || die
	echo "#define RPCS3_GIT_VERSION \"0000-${MY_SHA}\"" > rpcs3/git-version.h
	echo '#define RPCS3_GIT_BRANCH "master"' >> rpcs3/git-version.h
	echo '#define RPCS3_GIT_VERSION_NO_UPDATE 1' >> rpcs3/git-version.h
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DBUILD_LLVM_SUBMODULE=yes
		-DBUILD_SHARED_LIBS=no
		-DUSE_ALSA=$(usex alsa)
		-DUSE_DISCORD_RPC=yes
		-DUSE_LIBEVDEV=$(usex evdev)
		-DUSE_PULSE=$(usex pulseaudio)
		-DUSE_SYSTEM_ASMJIT=yes
		-DUSE_SYSTEM_FFMPEG=yes
		-DUSE_SYSTEM_GLSLANG=yes
		-DUSE_SYSTEM_HIDAPI=yes
		-DUSE_SYSTEM_LIBPNG=yes
		-DUSE_SYSTEM_PUGIXML=yes
		-DUSE_SYSTEM_XXHASH=yes
		-DUSE_SYSTEM_YAMLCPP=yes
		-DUSE_SYSTEM_ZLIB=yes
		-DUSE_VULKAN=$(usex vulkan)
		-DUSE_WAYLAND=$(usex wayland)
		-DWITH_LLVM=yes
		# FIXME Need patch to add back discord-presence USE flag
		# -DUSE_DISCORD_RPC=$(usex discord-presence)
	)
	cmake_src_configure
}

#src_install() {
#	cmake-utils_src_install
#	mv "${D}/usr/bin/rpcs3" "${D}/usr/bin/rpcs3.bin"
#	cat > rpcs3.sh <<EOF
#!/bin/sh
#export XDG_CURRENT_DESKTOP=qt
#/usr/bin/rpcs3.bin "\$@"
#EOF
#	newbin rpcs3.sh rpcs3
#	einstalldocs
#}

# pkg_postinst() {
# 	if use discord-presence; then
# 		einfo
# 		einfo 'Discord presence requires a running Discord client.'
# 		einfo 'To install the official client, emerge net-im/discord-bin'
# 		einfo
# 	fi
# }
