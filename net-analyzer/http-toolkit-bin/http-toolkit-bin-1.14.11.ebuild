# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils xdg

DESCRIPTION="Open source tool for debugging, testing and building with HTTP requests."
HOMEPAGE="https://github.com/httptoolkit/httptoolkit-desktop https://httptoolkit.com/"
MY_PN="HttpToolkit"
MY_PN_LOWER="${MY_PN,,}"
SRC_URI="https://github.com/${MY_PN_LOWER}/${MY_PN_LOWER}-desktop/releases/download/v1.14.11/$MY_PN-linux-x64-${PV}.zip -> ${P}.zip
	https://raw.githubusercontent.com/${MY_PN_LOWER}/${MY_PN_LOWER}-desktop/main/src/icons/icon.svg
	https://raw.githubusercontent.com/${MY_PN_LOWER}/${MY_PN_LOWER}-desktop/main/src/icons/icon.png"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="suid"
RESTRICT="strip"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/wayland[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/${MY_PN_LOWER}/chrome-sandbox
	opt/${MY_PN_LOWER}/chrome_crashpad_handler
	opt/${MY_PN_LOWER}/libEGL.so
	opt/${MY_PN_LOWER}/libGLESv2.so
	opt/${MY_PN_LOWER}/libffmpeg.so
	opt/${MY_PN_LOWER}/libvk_swiftshader.so
	opt/${MY_PN_LOWER}/libvulkan.so.1
	opt/${MY_PN_LOWER}/resources/${MY_PN_LOWER}-server/bin/node
	opt/${MY_PN_LOWER}/resources/${MY_PN_LOWER}-server/nss/linux/*
	opt/${MY_PN_LOWER}/resources/${MY_PN_LOWER}-server/node_modules/*
	opt/${MY_PN_LOWER}/${MY_PN_LOWER}
	opt/${MY_PN_LOWER}/swiftshader/libEGL.so
	opt/${MY_PN_LOWER}/swiftshader/libGLESv2.so"

S="${WORKDIR}"

src_install() {
	local ext
	insinto "/opt/${MY_PN_LOWER}"
	cp -a ./ "${ED}/opt/${MY_PN_LOWER}" || die "cp failed"
	use suid && fperms u+s "/opt/${MY_PN_LOWER}/chrome-sandbox"
	dosym "../../opt/${MY_PN_LOWER}/${MY_PN_LOWER}" "usr/bin/${MY_PN_LOWER}"
	pax-mark -m "${ED}/opt/${MY_PN_LOWER}/${MY_PN_LOWER}"
	make_desktop_entry "${MY_PN_LOWER}" 'HTTP Toolkit' "${MY_PN_LOWER}"
	newicon "${DISTDIR}/icon.png" "${MY_PN_LOWER}.png"
	newicon -s scalable "${DISTDIR}/icon.svg" "${MY_PN_LOWER}.svg"
	fperms 0755 "/opt/${MY_PN_LOWER}"
}
