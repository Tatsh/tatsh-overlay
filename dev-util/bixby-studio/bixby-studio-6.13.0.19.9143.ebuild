# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop unpacker

DESCRIPTION="Bixby Studio."
HOMEPAGE="https://bixbydevelopers.com"
SRC_URI="https://bixby-ide.s3.amazonaws.com/stable-c4f5c975-1d91-4065-b661-633de7275e11/BixbyStudio-6.13.0-r19l.9143-linux.deb"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	gnome-base/gconf:2
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	x11-libs/libXScrnSaver"
BDEPEND=""

S="$WORKDIR"

DOCS=( usr/share/doc/bixbystudio/changelog )

src_unpack() {
	unpack_deb 'BixbyStudio-6.13.0-r19l.9143-linux.deb'
	gunzip usr/share/doc/bixbystudio/changelog.gz
}

src_install() {
	mkdir "${D}/opt"
	cp -a 'opt/Bixby Studio' "${D}/opt"
	domenu usr/share/applications/bixbystudio.desktop
	for size in 128 16 24 256 32 48 512 64 96; do
		newicon -s "$size" "usr/share/icons/hicolor/${size}x${size}/apps/bixbystudio.png" bixbystudio.png
	done
	dosym '/opt/Bixby Studio/bixbystudio' /usr/bin/bixbystudio
	einstalldocs
}
