# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop wrapper

DESCRIPTION="Desktop chat client for Slack and Discord (not web-based)."
HOMEPAGE="https://cancel.fm/ripcord/"
SRC_URI="https://cancel.fm/dl/R${PN:1}-${PV}-x86_64.AppImage"

LICENSE="Ripcord"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist"

RDEPEND="dev-libs/libsodium:0/23
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[gstreamer]
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwebsockets:5
	dev-qt/qtwidgets:5
	media-libs/libglvnd
	media-libs/opus
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXScrnSaver"

QA_PREBUILT="/opt/${PN}/R${PN:1} /opt/${PN}/plugins/*/*.so"
DOCS=( additional_license_information.txt )

S="${WORKDIR}"

src_unpack() {
	cd "${WORKDIR}" || die "Failed to cd ${WORKDIR}"
	cp "${DISTDIR}/R${PN:1}-${PV}-x86_64.AppImage" . || die "Failed to copy"
	chmod +x ./"R${PN:1}-${PV}-x86_64.AppImage" || die "Failed to chmod"
	./"R${PN:1}-${PV}-x86_64.AppImage" --appimage-extract &>/dev/null || die "Failed to unpack"
}

src_install() {
	cd "${WORKDIR}/squashfs-root" || die "Failed to cd"
	sed -r -e 's/libsodium\.so\.18/libsodium.so.23/g' -i Ripcord || die "Failed to patch"
	exeinto /opt/${PN}
	doexe "R${PN:1}"
	insinto /opt/${PN}
	doins twemoji.ripdb
	insinto /usr/share/qt5/translations/
	doins translations/"${PN}_en.qm"
	newicon -s 512 "R${PN:1}_Icon.png" "${PN}.png"
	make_wrapper "${PN}" "env RIPCORD_ALLOW_UPDATES=0 /opt/${PN}/R${PN:1}" "/opt/${PN}"
	make_desktop_entry "${PN}" "R${PN:1}" "$PN" "Network;InstantMessaging;"
	einstalldocs
	cat > ${ED}/opt/${PN}/qt.conf <<EOF
[Paths]
Prefix = ./

[Paths]
Prefix = /usr/lib64/qt5
EOF
}
