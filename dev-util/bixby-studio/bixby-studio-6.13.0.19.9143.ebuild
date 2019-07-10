# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop unpacker

DESCRIPTION="Bixby Studio."
HOMEPAGE="https://bixbydevelopers.com"
REAL_PV="6.13.0-r19l.9143"
REAL_PN="BixbyStudio"
DEB="${REAL_PN}-${REAL_PV}-linux.deb"
SRC_URI="https://bixby-ide.s3.amazonaws.com/stable-c4f5c975-1d91-4065-b661-633de7275e11/${DEB}"

LICENSE="Samsung-DTLA MIT MIT-with-advertising BSD-1 BSD-2 BSD Apache-2.0 Boost-1.0 ISC CC-BY-SA-3.0 CC0-1.0 openssl ZLIB APSL-2 icu Artistic-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="gnome-base/gconf:2
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}"
BDEPEND=""

S="$WORKDIR"

LOWER_PN="${REAL_PN,,}"
OUTDIR='opt/Bixby Studio'
DOCS=( "usr/share/doc/${LOWER_PN}/changelog"
	"${OUTDIR}/LICENSE.electron.txt"
	"${OUTDIR}/LICENSES.chromium.html" )

QA_PRESTRIPPED="/opt/Bixby.*/${LOWER_PN}
	/opt/Bixby.*/lib.*\.so"

src_unpack() {
	unpack_deb "$DEB"
	gunzip "usr/share/doc/${LOWER_PN}/changelog.gz"
}

src_prepare() {
	sed -e "s:/usr/local/var/run/watchman:/run/watchman-${P}:" -i "${OUTDIR}/resources/init-watchman-state-dir.sh"
	default
}

src_install() {
	mkdir "${D}/opt"
	cp -a "$OUTDIR" "${D}/opt"
	domenu "usr/share/applications/${LOWER_PN}.desktop"
	for size in 128 16 24 256 32 48 512 64 96; do
		newicon -s "$size" "usr/share/icons/hicolor/${size}x${size}/apps/${LOWER_PN}.png" "${LOWER_PN}.png"
	done
	dosym "/${OUTDIR}/${LOWER_PN}" "/usr/bin/${LOWER_PN}"
	einstalldocs
}
