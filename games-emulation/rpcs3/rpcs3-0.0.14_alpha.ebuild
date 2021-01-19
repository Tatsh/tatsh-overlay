# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="PS3 emulator and debugger."
HOMEPAGE="https://rpcs3.net/"
MY_SHA="v0.0.14"
ASMJIT_SHA="fc251c914e77cd079e58982cdab00a47539d7fc5"
CEREAL_SHA="60c69df968d1c72c998cd5f23ba34e2e3718a84b"
HIDAPI_SHA="8961cf86ebc4756992a7cd65c219c743e94bab19"
LLVM_SHA="cb7748dfa0d615e9f5ea9f31e0ce40fe9aeac595"
YAML_CPP_SHA="6a211f0bc71920beef749e6c35d7d1bcc2447715"
WOLFSSL_SHA="39b5448601271b8d1deabde8a0d33dc64d2a94bd"
SPAN_SHA="9d7559aabdebf569cab3480a7ea2a87948c0ae47"
SRC_URI="https://github.com/RPCS3/rpcs3/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/RPCS3/llvm-mirror/archive/${LLVM_SHA}.tar.gz -> ${P}-llvm.tar.gz
	https://github.com/asmjit/asmjit/archive/${ASMJIT_SHA}.tar.gz -> ${P}-asmjit.tar.gz
	https://github.com/wolfSSL/wolfssl/archive/${WOLFSSL_SHA}.tar.gz -> ${P}-wolfssl.tar.gz
	https://github.com/RPCS3/hidapi/archive/${HIDAPI_SHA}.tar.gz -> ${P}-hidapi.tar.gz
	https://github.com/RPCS3/yaml-cpp/archive/${YAML_CPP_SHA}.tar.gz -> ${P}-yaml-cpp.tar.gz
	https://github.com/RPCS3/cereal/archive/${CEREAL_SHA}.tar.gz -> ${P}-cereal.tar.gz
	https://github.com/tcbrindle/span/archive/${SPAN_SHA}.tar.gz -> ${P}-span.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa pulseaudio evdev faudio vulkan +dbus wayland"
REQUIRED_USE="wayland? ( vulkan )"

DEPEND="dev-cpp/ms-gsl
	dev-libs/cereal
	dev-libs/discord-rpc
	dev-libs/pugixml
	dev-libs/xxhash
	dev-qt/qtcore:5
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-util/glslang
	faudio? ( media-libs/faudio )
	media-libs/libpng:=
	media-libs/openal
	media-video/ffmpeg
	sys-libs/zlib
	virtual/jpeg:=
	virtual/opengl
	alsa? ( media-libs/alsa-lib )
	evdev? ( dev-libs/libevdev )
	pulseaudio? ( media-sound/pulseaudio )
	vulkan? ( dev-util/vulkan-headers )
	wayland? ( dev-libs/wayland )"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA:1}"
PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" "${FILESDIR}/use-wayland.patch" )

src_prepare() {
	rmdir "${S}/llvm" || die
	mv "${WORKDIR}/llvm-mirror-${LLVM_SHA}" "${S}/llvm" || die
	rmdir "${S}/3rdparty/"{cereal,wolfssl,hidapi,yaml-cpp,span} || die
	mv "${WORKDIR}/wolfssl-${WOLFSSL_SHA}" "${S}/3rdparty/wolfssl" || die
	mv "${WORKDIR}/hidapi-${HIDAPI_SHA}" "${S}/3rdparty/hidapi" || die
	mv "${WORKDIR}/yaml-cpp-${YAML_CPP_SHA}" "${S}/3rdparty/yaml-cpp" || die
	mv "${WORKDIR}/cereal-${CEREAL_SHA}" "${S}/3rdparty/cereal" || die
	mv "${WORKDIR}/span-${SPAN_SHA}" "${S}/3rdparty/span" || die
	rmdir "${S}/asmjit" || die
	mv "${WORKDIR}/asmjit-${ASMJIT_SHA}" "${S}/asmjit" || die
	echo "#define RPCS3_GIT_VERSION \"0000-${MY_SHA}\"" > rpcs3/git-version.h
	echo '#define RPCS3_GIT_BRANCH "master"' >> rpcs3/git-version.h
	echo '#define RPCS3_GIT_VERSION_NO_UPDATE 1' >> rpcs3/git-version.h
	sed -r \
		-e 's/MATCHES "\^\(DEBUG\|RELEASE\|RELWITHDEBINFO\|MINSIZEREL\)\$/MATCHES "^(DEBUG|RELEASE|RELWITHDEBINFO|MINSIZEREL|GENTOO)/' \
		-i "${S}/llvm/CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-Wno-dev
		-DBUILD_EXTERNAL=OFF
		-DBUILD_LLVM_SUBMODULE=ON
		-DUSE_ALSA=$(usex alsa)
		-DUSE_DISCORD_RPC=OFF
		-DUSE_FAUDIO=$(usex faudio)
		-DUSE_LIBEVDEV=$(usex evdev)
		-DUSE_PULSE=$(usex pulseaudio)
		-DUSE_SYSTEM_CURL=ON
		-DUSE_SYSTEM_FFMPEG=ON
		-DUSE_SYSTEM_GLSLANG=ON
		-DUSE_SYSTEM_LIBPNG=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_SYSTEM_XXHASH=ON
		-DUSE_SYSTEM_ZLIB=ON
		-DUSE_SYS_LIBUSB=ON
		-DUSE_VULKAN=$(usex vulkan)
		-DUSE_WAYLAND=$(usex wayland)
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
