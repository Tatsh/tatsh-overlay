# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="Unofficial remaster of the original game."
HOMEPAGE="https://github.com/JHDev2006/Super-Mario-Bros.-Remastered-Public"
GODOT_VERSION=4.5.1
SRC_URI="https://github.com/JHDev2006/Super-Mario-Bros.-Remastered-Public/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz"
S="${WORKDIR}/Super-Mario-Bros.-Remastered-Public-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip"

BDEPEND=">=dev-games/godot-${GODOT_VERSION}[tools]"

pkg_setup() {
	if has_version -b ">=dev-games/godot-${GODOT_VERSION}[double-precision]"; then
		ewarn 'dev-games/godot is known to fail to with USE=double-precision for this package.'
		ewarn 'If this build fails, re-build dev-games/godot with USE=-double-precision.'
	fi
}

src_unpack() {
	default
	local suffix=x86_64
	if use arm64; then
		suffix=arm64
	fi
	unzip "${DISTDIR}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz" \
		"templates/linux_release.${suffix}" templates/icudt_godot.dat || die
	mkdir -p "${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable" || die
	mv "templates/linux_release.${suffix}" templates/icudt_godot.dat \
		"${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable" || die
}

src_prepare() {
	default
	addwrite /dev/input
	local i
	for i in /dev/video* /dev/bus/usb/*/*; do
		addpredict "$i"
	done
}

src_compile() {
	mkdir build
	local template='Linux x86'
	if use arm64; then
		template='Linux ARM64'
	fi
	godot --no-header --headless --verbose --export-release "${template}" build/SMB1R || die
}

src_install() {
	exeinto "/usr/share/${PN}"
	doexe build/SMB1R build/libgodot*.so
	insinto "/usr/share/${PN}"
	doins build/SMB1R.pck
	make_wrapper SMB1R ./SMB1R "/usr/share/${PN}"
	newicon -s 256 icon.png "${PN}.png"
	make_desktop_entry SMB1R 'Super Mario Bros. Remastered' "${PN}"
	einstalldocs
}
