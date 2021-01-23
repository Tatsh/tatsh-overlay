# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop

DESCRIPTION="Desktop chat client for Slack and Discord (not web-based)."
HOMEPAGE="https://cancel.fm/ripcord/"
SRC_URI="https://cancel.fm/dl/R${PN:1}-${PV}-x86_64.AppImage"

LICENSE="Ripcore"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist"

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/libsodium:0/23
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[gstreamer]
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwebsockets:5
	dev-qt/qtwidgets:5
	media-libs/opus
	virtual/opengl"
BDEPEND=""

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
	doins -r translations twemoji.ripdb
	newicon -s 512 "R${PN:1}_Icon.png" "${PN}.png"
	cat > "${PN}.sh" <<EOF
#!/usr/bin/env bash
cd /opt/${PN}
exec ./R${PN:1}
EOF
	newbin "${PN}.sh" "${PN}"
	make_desktop_entry "${PN}" "R${PN:1}" "$PN" "Network;InstantMessaging;"
	einstalldocs
	dodir /opt/${PN}/plugins/iconengines
	cp plugins/iconengines/libqsvgicon.so "${ED}/opt/${PN}/plugins/iconengines" || die "Copy failed"
	dodir /opt/${PN}/plugins/platforms
	cp plugins/platforms/libqxcb.so "${ED}/opt/${PN}/plugins/platforms" || die "Copy failed"
	cat > ${ED}/opt/${PN}/qt.conf <<EOF
[Paths]
Prefix = ./
Plugins = plugins
Translations = translations
EOF
}
