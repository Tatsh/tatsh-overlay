# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit desktop

DESCRIPTION="Freeware version of IDA v7.0"
HOMEPAGE="https://www.hex-rays.com/products/ida/support/download_freeware.shtml"
SRC_URI="https://out7.hex-rays.com/files/idafree70_linux.run"
RESTRICT="strip mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	einfo 'Nothing to unpack'
}

src_prepare() {
	cp "${DISTDIR}/idafree70_linux.run" .
	chmod +x ./idafree70_linux.run
	default
}

src_install() {
	local -r outdir="${D}/opt/idafree-7.0"
	./idafree70_linux.run --debuglevel 4 --mode unattended --prefix "$outdir"
	mv "${outdir}/appico64.png" idafree-7.0.png
	rm ./idafree70_linux.run "${outdir}/Uninstall IDA Free.desktop" "${outdir}/uninstall"*
	dodoc "${outdir}/license.txt"
	doicon -s 64 idafree-7.0.png
	dosym /opt/idafree-7.0/ida64 /opt/bin/ida64
	make_desktop_entry ida64 "IDA Free" idafree-7.0 Development "Version=0.9.4\nTerminal=false"
}
